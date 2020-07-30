% % % % % % % % % % 主成分分析% % % % % % % % %
%% 计算初筛片段的特征向量矩阵的主成分
function [main_feature_matrix, V_feature] = main_feature_analyze(matrix_orignal)	
feature = matrix_orignal(:,5:19); % 后面15列才是特征！！！！！
%% 输入一个m*n的矩阵： m是样点个数（即运动片段数），n是指标个数，即特征数目
x = feature + eps; % 防止有接近于0的值使得后续计算出现NaN
[n,p] = size(x);  % n是样本个数，p是指标个数

%% 第一步：对数据x标准化
% 计算样本相关矩阵
R = corrcoef(x);

%% 第二步：计算R的特征值和特征向量

[V_spec,D_lamda] = eig(R);  % V 特征向量矩阵  D 特征值构成的对角矩阵

V_spe = fliplr(V_spec); % 改为大特征值对应的特征向量放在前面


%% 第三步：计算主成分贡献率和累计贡献率
lambda = diag(D_lamda);  % diag函数用于得到一个矩阵的主对角线元素值(返回的是列向量)
lambda = lambda(end:-1:1);  % 因为lambda向量是从小大到排序的，我们将其调个头
contribution_rate = lambda / sum(lambda);  % 计算贡献率
cum_contribution_rate = cumsum(lambda)/ sum(lambda);   % 计算累计贡献率  cumsum是求累加值的函数
contribution_rate = contribution_rate * 100;
cum_contribution_rate  = cum_contribution_rate *100;

%% 计算我们所需要的主成分的值

% for i =1:p
%     if(cum_contribution_rate(i) >85 )
%         m = i;
%         break
%     end
% end
m = 6; % 经观察，3个文件有的需要5个主成分就可以达到85%，但有的需要6个，故为统一，都选6个
V_feature = V_spe(:,1:m);
% F = zeros(n,m);  %初始化保存主成分的矩阵（每一列是一个主成分）
for i = 1:m
    ai = V_spe(:,i)';   % 将第i个特征向量取出，并转置为行向量
    ac = repmat(ai,n,1);   % 将这个行向量重复n次，构成一个n*p的矩阵
    main_feature_matrix(:, i) = sum(ac .* x, 2);  % 注意，对标准化的数据求了权重后要计算每一行的和
end
main_feature_matrix = [matrix_orignal(:,1:4) main_feature_matrix];  % 这里还是要把来源和位置信息加上，加在1:3列
disp(['初筛片段特征值矩阵的主成分分析已经完毕'])
end
