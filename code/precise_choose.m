function final_frags = precise_choose(main_feature_matrix)
% ���룺��ɸ����˶�ѧƬ�ε�6�����ɷ�����
disp(['��ɸǰƬ�������ǣ�',num2str(size(main_feature_matrix,1))])
% DBSCAN����뾶
radius = 300;
% ���ĵ㣬�߽�㣬��Ⱥ����ʱ�����ٵ���
least_points = 38;
% C_num = 0;

[C_num, isoutlier] = DBSCAN(main_feature_matrix(:,5:10),radius,least_points);
% C_num�Ǿ�����Ŀ��������ȡ01��������ȡ012```������������ɸѡ��Ⱥ�㣬����Ӧ����radius��least_pointsʹ��C_num=1���õ�����Ƭ��
% ��Ⱥ�㣨����������
% while(length(find(C_num==2))~=0)
%     % ���û�о�Ϊһ�࣬����ʾ�����뾶�����ٵ�����������
% %     disp(['DBSCANû�о�Ϊһ�࣬Ӧ����뾶radius���С���ٵ���least_points'])
% %     disp(['��ǰradius=',num2str(radius)])
% %     radius = str2num(input('������Сһ���radius:','s'));
% %     disp(['��ǰleast_points=',num2str(least_points)])
% %     least_points = str2num(input('�������һ���least_points:','s'));
% %       radius = radius+1;
%       least_points = least_points-1;
%       if least_points==0
%           disp('least_points�Ѽ���0')
%       end
%       [C_num, isoutlier] = DBSCAN(main_feature_matrix(:,5:10),radius,least_points);
% end



disp(['��ȺƬ������Ϊ��',num2str(size(find(isoutlier==1),1))])


% ���ӻ�������
plot_filter_result(main_feature_matrix(:,5:10), C_num);
title(['DBSCAN����ɸ����ȺƬ�� (\epsilon = ' num2str(radius) ', minpts = ' num2str(least_points) ')']);
% saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\','dbscan_cluster_fig.jpg']);%�����ͼƬ
% close
% ������ɸʣ���Ƭ��
reserve = find(isoutlier==0);
final_frags = main_feature_matrix(reserve,:);
disp(['��ɸ��ʣ��Ƭ�������ǣ�',num2str(size(final_frags,1))])



end