function final_frags = precise_choose(main_feature_matrix)
% 输入：初筛后的运动学片段的6个主成分向量
disp(['精筛前片段总数是：',num2str(size(main_feature_matrix,1))])
% DBSCAN聚类半径
radius = 300;
% 核心点，边界点，离群点检测时的最少点数
least_points = 38;
% C_num = 0;

[C_num, isoutlier] = DBSCAN(main_feature_matrix(:,5:10),radius,least_points);
% C_num是聚类数目（两类则取01，三类则取012```），我们用于筛选离群点，所以应调整radius和least_points使得C_num=1，得到噪声片段
% 离群点（噪声）总数
% while(length(find(C_num==2))~=0)
%     % 如果没有聚为一类，就提示调整半径和最少点数两个参数
% %     disp(['DBSCAN没有聚为一类，应调大半径radius或调小最少点数least_points'])
% %     disp(['当前radius=',num2str(radius)])
% %     radius = str2num(input('请输入小一点的radius:','s'));
% %     disp(['当前least_points=',num2str(least_points)])
% %     least_points = str2num(input('请输入大一点的least_points:','s'));
% %       radius = radius+1;
%       least_points = least_points-1;
%       if least_points==0
%           disp('least_points已减到0')
%       end
%       [C_num, isoutlier] = DBSCAN(main_feature_matrix(:,5:10),radius,least_points);
% end



disp(['离群片段总数为：',num2str(size(find(isoutlier==1),1))])


% 可视化聚类结果
plot_filter_result(main_feature_matrix(:,5:10), C_num);
title(['DBSCAN聚类筛除离群片段 (\epsilon = ' num2str(radius) ', minpts = ' num2str(least_points) ')']);
% saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\','dbscan_cluster_fig.jpg']);%保存该图片
% close
% 经过精筛剩余的片段
reserve = find(isoutlier==0);
final_frags = main_feature_matrix(reserve,:);
disp(['精筛后剩余片段总数是：',num2str(size(final_frags,1))])



end