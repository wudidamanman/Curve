% % % % % % % % % % 主程序 % % % % % % % % % %
clc
clear all
close all
load v1 % 文件1的车速数据
load v2
load v3
load abs_seconds1 % 文件1原始数据日期的绝对秒（UTC）
load abs_seconds2
load abs_seconds3


v_interp1 = data_preprocess(v1,abs_seconds1); 
v_interp2 = data_preprocess(v2,abs_seconds2);
v_interp3 = data_preprocess(v3,abs_seconds3);
save v_interp1.mat v_interp1
save v_interp2.mat v_interp2
save v_interp3.mat v_interp3


%% 至此数据预处理结束，开始划分运动学片段
data_chip_feature1 = divide_into_frags(v_interp1,1); % 初筛后的片段的特征矩阵（每行是一个片段的特征向量以及来源和位置信息）
% data_chip_feature的行数表示初筛后剩余片段总数
data_chip_feature2 = divide_into_frags(v_interp2,2); % 1表示来源于数据文件1
data_chip_feature3 = divide_into_frags(v_interp3,3);
% 把三个文件的初筛片段的（的特征向量）汇在一起
data_chip_feature = [data_chip_feature1;data_chip_feature2;data_chip_feature3];


%  由初筛片段特征值矩阵进行主成分分析
[main_feature_matrix,V_feature] = main_feature_analyze(data_chip_feature);


% DBSCAN层次聚类精筛片段，筛除显著离群片段（异常片段）
final_frags = precise_choose(main_feature_matrix);


% 将最终的片段final_frags在spss.mat进行层次聚类(用excel打开)
save final_frags.mat final_frags
disp(['精筛片段已经保存到final_frags.mat中，请前往spss进行层次聚类，完成后请将结果存入hierarchical_cluster_result.mat'])
% 层次聚类结果直接粘贴到这边的hierarchical_cluster_result.mat文件进行后续的构建工况片段筛选
disp('final_frags 的第1列是来源，2:4列是位置，5:10是特征')
disp('hierarchical_cluster_result 的前10列是final_frags，第11列是层次聚类结果')

% 从三个类中选择片段构建工况曲线
curve_build;