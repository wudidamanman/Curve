%计算所有时间不连续点的距离，观察距离分布，得到的数据用于绘制论文中断点距离占比饼图
function [sort_dis_table] = distance_break_point(ind_break,abs_seconds)
load lati_longi_1 % 文件1的经纬度数据
% 经观察发现经纬度数据有丢失为0的情况，用上一秒的经纬数据补全
ind_0 = find(lati_longi_1==0);
for i =1:length(ind_0)
    lati_longi_1(ind_0(i)) = lati_longi_1(ind_0(i)-1) ;
end

R = 6371; %地球半径，km
phi_x = lati_longi_1(:,1)*pi/180; %经纬度变换为极坐标角度
phi_y = lati_longi_1(:,2)*pi/180;   
distance_earth = []; 
V =[];

for i =1: length(ind_break)
    p1 = ind_break(i);
    p2 = ind_break(i)+1;
    temp = real( R * acos(cos(phi_x(p1)-phi_x(p2))*cos(phi_y(p1))*cos(phi_y(p2))+sin(phi_y(p1))*sin(phi_y(p2)))*1000); % 米
    T = abs_seconds(p2) - abs_seconds(p1); % 秒
    distance_earth = [distance_earth temp];
    v_cal = temp / T; % 速度，m/s
    V =[V v_cal];
end
sort_dis_table = (sort(distance_earth)/1000)'; % km
end