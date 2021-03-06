% 用状态机划分运动片段
% 输入速度
% 输出初筛后的片段的特征矩阵（每行是一个片段的特征向量）
function data_chip_feature = divide_into_frags(v_interp,from) 
state = 0; % 初始状态
tf = 2; % 怠速速度门限 m/s
num = 1;
vehicle_v = v_interp;
length_vehicle_v = length(vehicle_v);
for i = 1:length_vehicle_v
    if state == 0 % 状态为0则找怠速起点，即速度小于2m/s的第一个点
        if vehicle_v(i) < tf  
            state = 1; % 找到怠速起点则设置状态为1
            pre_frag_ind(num) = i;
            num = num +1;
        end
    end
    if (state == 1)
        if (vehicle_v(i)) >= tf % 状态为1则找速度大于2m/s的第一个点
            state = 0; % 又去找0
            pre_frag_ind(num) = i;
            num = num +1;
        end
    end
end

% 初筛前的总运动片段数目
pre_frag_num = (length(pre_frag_ind)-1)/2;
disp(['初筛前检测到的片段总数是：',num2str(pre_frag_num)])

num_for = 0;
num_Tf_dt = 0;
data_chip_feature = zeros(length(pre_frag_num),19); % 列1表示片段来源， 2:4列是片段起点和终点等位置索引， 5:19列是特征
data_chip_feature(:,1) = from; % 表示是来自于文件几的片段
Tf_dt_idle = [];
for i = 1:2:length(pre_frag_ind)-2
    
    Tf_dt_tt = pre_frag_ind(i+2) - pre_frag_ind(i); %片段的长度
    Tf_dt_tm = pre_frag_ind(i+2) - pre_frag_ind(i+1);   %片段的运动长度
    
    if (Tf_dt_tt >= 20 && Tf_dt_tm >= 5)
        % 初筛，选出总长度大于20且运动长度大于5的片段
        num_Tf_dt = num_Tf_dt + 1;    % 初筛后的有效片段数目
        Tf_dt_idle_temp = pre_frag_ind(i+1) - pre_frag_ind(i); % 片段的怠速长度
        if (Tf_dt_idle_temp > 180)
            % 怠速时间长于180s
            pre_frag_ind(i) = pre_frag_ind(i+1) - 180;
        end
        Tf_dt_idle_temp = pre_frag_ind(i+1) - pre_frag_ind(i); % 片段的新怠速长度
        Tf_dt_idle = [Tf_dt_idle Tf_dt_idle_temp];   
        Tf_dt(num_Tf_dt) = pre_frag_ind(i+2) - pre_frag_ind(i);     %计算各片段总时间
        data_chip = v_interp(pre_frag_ind(i):pre_frag_ind(i+2) -1); %该片段的速度数据,m/s
        
        
        % 初筛后的片段，先提取特征，再进行主成分分析，然后用DBSCAN密度聚类精筛显著离群片段
        [data_chip_feature(num_Tf_dt,5:19),isvalid] = feature_pick(data_chip,Tf_dt_idle(num_Tf_dt));  %各个片段的特征返回矩阵
        data_chip_feature(num_Tf_dt,2:4)=[pre_frag_ind(i) pre_frag_ind(i+1)  pre_frag_ind(i+2)]; % 在特征向量后面加上索引，方便后面用
        data_chip_feature(:,1) = from; % 表示是来自于文件1的片段
        if isvalid == 0
            num_Tf_dt = num_Tf_dt -1; % 片段无效，删除
            data_chip_feature(end,:) = []; % 删除当前片段的特征向量（最后一行）
        end
        
    end
end

disp(['初筛后剩余片段总数是：',num2str(size(data_chip_feature,1))])
end