%% 数据预处理
% 大于等于500s的间隔的起点索引,直接判定这些点是正常熄火停车导致数据时间不连续
% 判定为正常熄火停车的点用于后续检测异常加速度时的对照，这些点虽然会检测出异常加速度值，但却是应该出现的现象
% 因为怠速时间比是工矿曲线的重要因素，用于构建工矿曲线的怠速数据必须是真实怠速数据
% 不能把停车数据作为怠速，会造成工矿曲线计算不合理

function v_interp = data_preprocess(v,abs_seconds)
v_speed = v/3.6; % 车速，m/s
abs_seconds_diff = abs_seconds(2:end) - abs_seconds(1:end - 1) - 1; % 计算不连续时间间隔(绝对秒的差分)，连续则为0
Threshold = 500; % 不连续间隔的后续处理隔断阈值
ind_large_than_threshold = find(abs_seconds_diff >= Threshold); % 停车熄火
ind_less_than_threshold = find(abs_seconds_diff <= Threshold & abs_seconds_diff >=2); % [2,500)s的间隔索引，熄火或丢失
ind_break = [ind_less_than_threshold ;ind_large_than_threshold]; 
disp(['时间不连续点总数为：',num2str(size(ind_break,1))])

[sort_dis_table] = distance_break_point(ind_break,abs_seconds); % 此函数运行结果用于excel绘制论文中断点距离占比饼图
% 寻找GPS丢失索引
[gps_loss_ind,gps_sec,sum_add_sec] = get_gps_loss(ind_less_than_threshold,abs_seconds,abs_seconds_diff);
disp(['时间不连续点中属于GPS丢失的总数为：',num2str(size(gps_loss_ind,1))])
disp(['时间不连续点中属于长时间熄火停车的总数为：',num2str(size(ind_break,1)-size(gps_loss_ind,1))])
% 补全丢失速度
[v_interp,abs_sec_interp] = gps_interp(v_speed,sum_add_sec,gps_loss_ind,abs_seconds,gps_sec);


% 处理加速度异常值
v_interp = acc_abnormal(v_interp,abs_sec_interp);

disp('数据预处理结束')
end