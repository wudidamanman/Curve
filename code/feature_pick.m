%% 提取初筛后片段的特征的函数
% % % % % % % % % % 运动学片段的特征提取% % % % % % % % %
function [all_feature_vector,isvalid] = feature_pick(vector_orignal,K)	% K 怠速时间长度
if nargin<2
    K = 10; % 如果不输入怠速时间长度，则默认为10
end
 data_preprocessed = vector_orignal;
%%
v_data_preprocesd_m  = data_preprocessed';	%汽车瞬时速度 （m/s）
% v_data_preprocesd_m = v_data_preprocesd/3.6;	%汽车瞬时速度 
T_chip =  length(v_data_preprocesd_m); % 片段长度
T_idle = K;	%怠速时间长度

% % 每一行存储一个运动学片段的索引
% % 运动学片段数目等于行数 n
% % 列数 m 等于最长运动学片段的长度
% [n,m] = size(sport_frag); 
% 计算每个片段的运动学特征指标
%%	变速
%	加速度计算 vehicle_a
	vehicle_a = v_data_preprocesd_m(2:end) - v_data_preprocesd_m(1:end-1) ;% a = dv/dt
%	Tf_speedup 时间计算 seconds
	Tf_speedup_num = length(find(vehicle_a>0.15));
	Tf_slowdown_num = length(find(vehicle_a<-0.15));
	Tf_stablerun_num = length(find(vehicle_a>=-0.15 & vehicle_a<=0.15));
	%时间比
	rate_Tf_speedup = Tf_speedup_num/length(vehicle_a) + eps;
	rate_Tf_slowdown = Tf_slowdown_num/length(vehicle_a) + eps;
	rate_Tf_stablerun = (Tf_stablerun_num - T_idle)/length(vehicle_a) + eps;		%这里应该要考虑怠速时间才对
	rate_Tf_stablestop = (T_idle)/length(vehicle_a) + eps;	%怠速时间比
	
%%	距离
	vehicle_S = sum(v_data_preprocesd_m) + eps;	%单位m
	
	
%%	速度特征	m/s
	vehicle_v_max = max(v_data_preprocesd_m) + eps;	%最大速度
	vehicle_v_mean = vehicle_S/length(v_data_preprocesd_m) + eps;	%平均速度
	%vehicle_v_mean_real = vehicle_S/((length(v_data_preprocesd_m)-T_daisu) + eps);	%平均行驶速度
    vehicle_v_mean_real = vehicle_S/((T_chip-T_idle) + eps);	%平均行驶速度
	vehicle_v_standard = sqrt(1/(T_chip)* sum((v_data_preprocesd_m-vehicle_v_mean).^2)) + eps;	%该片段标准差

%%	其他特征 m/s^2
	vehicle_speedup_max = max(vehicle_a) + eps;	%最大加速度
	vehicle_speedup_temp = vehicle_a(find((vehicle_a>0.15)));
    if (Tf_speedup_num >0)
        vehicle_speedup_mean = sum(vehicle_a(find((vehicle_a>0.15))))/Tf_speedup_num + eps;	%平均加速度
        vehicle_speedup_std = sqrt(1/(Tf_speedup_num)* sum((vehicle_speedup_temp -vehicle_speedup_mean).^2))+ eps;	%该片段 加速度标准差
    else
        vehicle_speedup_mean = 0  + eps;	%平均加速度
        vehicle_speedup_std = 0  + eps;
    end
    
    %----------------------------------------------------------------------
	vehicle_slowdown_max = abs(min(vehicle_a)) + eps;	%最大减速度 绝对值
	vehicle_slowdown_temp = vehicle_a(find((vehicle_a< -0.15))) + eps;
    if (Tf_slowdown_num >0)
        vehicle_slowdown_mean = sum(vehicle_a(find((vehicle_a>0.15))))/(Tf_speedup_num + eps);	%平均加速度
        vehicle_slowdown_std = sqrt(1/(Tf_speedup_num + eps)* sum((vehicle_slowdown_temp -vehicle_slowdown_mean).^2))  + eps;	%该片段 加速度标准差
    else
        vehicle_slowdown_mean = 0 + eps;	%平均加速度
        vehicle_slowdown_std = 0 + eps;
    end
% 	vehicle_slowdown_mean = abs( sum(vehicle_a(find((vehicle_a<-0.15))))/Tf_slowdown_num );	%平均减速度
% 	vehicle_slowdown_std = sqrt(1/(Tf_slowdown_num)* sum((vehicle_slowdown_temp -vehicle_slowdown_mean).^2));	%该片段 加速度标准差
	
%%	速度分段特征
%	vehicle_v_0to10 = find(v_data_preprocesd_m>0 & v_data_preprocesd_m =<10/3.6);	% 0到10km/h
	vehicle_v_divide_Num = 9;
	vehicle_v_divide_T = zeros(1,vehicle_v_divide_Num);
	for i = 1:vehicle_v_divide_Num-1	%计算 0 to 80各段时间点数
		vehicle_v_divide_T(i) = length( find(v_data_preprocesd_m>(10*(i-1)/3.6) & v_data_preprocesd_m <=(10*i/3.6)) ) + eps;
	end
	vehicle_v_divide_T(vehicle_v_divide_Num) = length( find(v_data_preprocesd_m > (80/3.6))) + eps;
	vehicle_v_divide_rate = vehicle_v_divide_T/(T_chip-T_idle) + eps;	%	计算出比例
	
%%	拼接特征向量

% [最大速度 平均速度 平均行驶速度 速度标准差 ...   x4
%  最大加速度 平均加速度 加速度标准差 最大减速度 平均减速度 减速度标准差 ...    x6
            %  加速时间比 减速时间比 怠速时间比] x3
            % [发动机转速 最大值 平均值 标准差 扭矩百分比 瞬时油耗 油门踏板开度 空燃比 发动机负荷百分比 进气量] ; 7*3 个
% [行驶距离 行驶时间 加速时间 减速时间 匀速时间 怠速时间]   x6
all_feature_vector = [vehicle_v_max vehicle_v_mean vehicle_v_mean_real vehicle_v_standard    ...
	vehicle_speedup_max vehicle_speedup_mean vehicle_speedup_std vehicle_slowdown_max vehicle_slowdown_mean ...
     vehicle_S	T_chip Tf_speedup_num Tf_slowdown_num Tf_stablerun_num  T_idle     ...
];

% 如果片段有异常大的特征值就作为无效片段删除
temp = length(find(all_feature_vector>8000));
if temp~=0
    isvalid = 0; % 片段无效，删除
else 
    isvalid = 1;
end