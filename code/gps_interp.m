%% 使用分段三次样条插值进行区间插值，将GPS信号丢失导致的丢失车速补全
% 本程序检测原始数据的时间不连续点，将不连续点分为停车熄火和GPS信号丢失两种情况
% 判决准则：
% 先看时间间隔T
% 若T>500s，一定是熄火停车；若T<=500s，可能是停车，也可能是信号丢失；
% 对于T<=500s，再看间隔端点的距离S
% 若S<10m,一定是停车；若S>10m，可能是信号丢失，也可能另一段数据开始，所以再用速度V判断
% V=S/T(V不是车速)，若V>30m/s(108km/h),则一定是另一段数据开始，并不是GPS信号丢失，因为隧道的最高限速80km/h

function [v_interp,abs_sec_interp] = gps_interp(v_speed,sum_add_sec,gps_loss_ind,abs_seconds,gps_sec)
v_interp = zeros(1,length(v_speed) + sum_add_sec); % 初始化待插值的车速
abs_sec_interp = zeros(size(v_interp)); % 新的绝对时间，用于检测加速度毛刺
added_sec = 0; % 已经添加的秒数
start_indx = gps_loss_ind(1);
end_indx = start_indx;
v_interp(1:start_indx) = v_speed(1:start_indx); % 速度
abs_sec_interp(1:start_indx)= abs_seconds(1:start_indx); % 时间

mkdir('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\速度插值前后对比图');

% 取丢失间隔左右各n个点，n为丢失点数(间隔长度)，即预测节点：插值节点 = 1:2
for j = 1:length(gps_loss_ind) - 1
    for i = 1:length(v_speed)
        if (i == gps_loss_ind(j))          
            old_ind = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)+gps_sec(j) ]; % 画图用
            old_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j),gps_loss_ind(j)+gps_sec(j)+1:gps_loss_ind(j)+2*gps_sec(j) ];  % 插值用
            new_ind = [gps_loss_ind(j)+1:gps_loss_ind(j)+ gps_sec(j) ]; % 插值用
            new_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j) + 2*gps_sec(j)]; % 画图用
            % 速度
            new_v_speed = spline(old_ind_,v_speed(old_ind),new_ind) + randn; %加入速度扰动，避免太过于光滑;
            new_v_speed( new_v_speed<0) = 0; % 不能插入不可能的负值
            new_v_speed( new_v_speed>110) = 110; % 不能插入不可能的特大值
            new_abs_sec = abs_seconds(gps_loss_ind(j))+1 : abs_seconds(gps_loss_ind(j))+gps_sec(j);    
            
%             % 画出速度插值前后的图像，取消注释可运行，对文件1数据的运行结果保存在附件中
%             figure(j)
%             subplot(2,1,1)
%             plot(old_ind,v_speed(old_ind),'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(gps_loss_ind(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS信号丢失速度插值前')
%             subplot(2,1,2)
%             plot(new_ind_,[v_speed(gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)); new_v_speed'; v_speed(gps_loss_ind(j)+1:gps_loss_ind(j)+gps_sec(j))],'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(new_ind,new_v_speed,'g*')
%             plot(gps_loss_ind(j)+gps_sec(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS信号丢失速度插值后')
%             saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\速度插值前后对比图\',strcat('gps_v_interp', num2str(j) , '.jpg')]);
%             close % 关闭当前图形
            
            v_add_temp = new_v_speed;
            t_add_temp = new_abs_sec;
        end
    end
    
    end_indx = start_indx + gps_sec(j)+ 1; 
    v_interp(start_indx + 1:end_indx - 1) = v_add_temp;
    abs_sec_interp(start_indx + 1:end_indx - 1) = t_add_temp;
    added_sec = added_sec + gps_sec(j) ; % 当前共添补的时间点数
    start_indx = gps_loss_ind(j + 1) +  added_sec ;
    v_interp(end_indx:start_indx) = (v_speed((gps_loss_ind(j) + 1):(gps_loss_ind(j + 1))))';
    abs_sec_interp(end_indx:start_indx) = (abs_seconds((gps_loss_ind(j) + 1):(gps_loss_ind(j + 1))))';
end

for j = length(gps_loss_ind)
    start_indx = gps_loss_ind(j) +  added_sec;
    for i = 1:length(v_speed)
        if (i == gps_loss_ind(j))
            old_ind = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)+gps_sec(j) ]; % 画图用
            old_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j),gps_loss_ind(j)+gps_sec(j)+1:gps_loss_ind(j)+2*gps_sec(j)]; % 插值用
            new_ind = [gps_loss_ind(j)+1:gps_loss_ind(j)+ gps_sec(j) ]; % 插值用
            new_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j) + 2*gps_sec(j)]; % 画图用
            new_v_speed = spline(old_ind_,v_speed(old_ind),new_ind) + randn; %加入速度扰动，避免太过于光滑
            new_v_speed( new_v_speed>110) = 110; % 不能插入不可能的特大值
            new_v_speed( new_v_speed<0) = 0; % 不能插入不可能的负值
            new_abs_sec = abs_seconds(gps_loss_ind(j))+1 : abs_seconds(gps_loss_ind(j))+gps_sec(j);
            v_add_temp = new_v_speed;
            t_add_temp = new_abs_sec;      
            
% %           % 画出速度插值前后的图像,取消注释可运行，对文件1数据的运行结果保存在附件中
%             figure(j)
%             subplot(211)
%             plot(old_ind,v_speed(old_ind),'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(gps_loss_ind(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS信号丢失速度插值前')
%             subplot(212)
%             plot(new_ind_,[v_speed(gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)); new_v_speed'; v_speed(gps_loss_ind(j)+1:gps_loss_ind(j)+gps_sec(j))],'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(new_ind,new_v_speed,'g*')
%             plot(gps_loss_ind(j)+gps_sec(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS信号丢失速度插值后')
%             saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\速度插值前后对比图\',strcat('gps_v_interp', num2str(j) , '.jpg')]);
%             close % 关闭当前图形
             
        end
    end
    end_indx = start_indx + gps_sec(j)+ 1; 
    v_interp(start_indx + 1:end_indx - 1) = v_add_temp;
    abs_sec_interp(start_indx + 1:end_indx - 1) = t_add_temp;
    added_sec = added_sec + gps_sec(j) ; % 当前共添补的时间点数
    % 就后面这点和上面那个循环不一样，，要插入原来的速度和时间，不能有j+1
    start_indx = length(abs_sec_interp) ;
    v_interp(end_indx:start_indx) = (v_speed((gps_loss_ind(j) + 1):end))';
    abs_sec_interp(end_indx:start_indx) = (abs_seconds((gps_loss_ind(j) + 1):end))';
end
disp(['GPS丢失速度已补全，总共补充了',num2str(sum_add_sec),'秒'])
disp(['补全GPS丢失速度后总记录是',num2str(length(v_interp)),'秒'])
end