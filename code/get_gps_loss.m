%% 计算T<500s的不连续点的距离S和对应速度V，检测gps信号丢失的索引
function [gps_loss_ind,gps_sec,sum_add_sec] = get_gps_loss(ind_less_than_threshold,abs_seconds,abs_seconds_diff)
load lati_longi_1 % 文件1的经纬度数据

%% 经纬度异常数据预处理
% 经观察发现经纬度数据有丢失为0的情况，用上一秒的经纬数据补全
ind_0 = find(lati_longi_1==0);
for i =1:length(ind_0)
    lati_longi_1(ind_0(i)) = lati_longi_1(ind_0(i)-1) ;
end

R = 6371; %地球半径，km
phi_x = lati_longi_1(:,1)*pi/180; %经纬度变换为极坐标角度
phi_y = lati_longi_1(:,2)*pi/180;

gps_loss_ind = []; % 初始化gps信号丢失的间隔索引
for i=1:length(ind_less_than_threshold)
    p1 = ind_less_than_threshold(i);
    p2 = ind_less_than_threshold(i)+1;
    distance_earth = R * acos(cos(phi_x(p1)-phi_x(p2))*cos(phi_y(p1))*cos(phi_y(p2))+sin(phi_y(p1))*sin(phi_y(p2)))*1000;
    t = abs_seconds(p2) - abs_seconds(p1);
    v = distance_earth / t;
    flag = (distance_earth > 10) && (v<30);
    if (v>60 || flag==1)
        % 80/3.6=22  隧道限速80km/h
        % 判定为GPS信号丢失,则插值补充数据
        gps_loss_ind = [gps_loss_ind ind_less_than_threshold(i)];
    end
end
gps_loss_ind = gps_loss_ind';
gps_sec= abs_seconds_diff(gps_loss_ind); % gps丢失的间隔长度
sum_add_sec = sum(gps_sec); % 总添补时间秒数
end