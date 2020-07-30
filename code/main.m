% % % % % % % % % % ������ % % % % % % % % % %
clc
clear all
close all
load v1 % �ļ�1�ĳ�������
load v2
load v3
load abs_seconds1 % �ļ�1ԭʼ�������ڵľ����루UTC��
load abs_seconds2
load abs_seconds3


v_interp1 = data_preprocess(v1,abs_seconds1); 
v_interp2 = data_preprocess(v2,abs_seconds2);
v_interp3 = data_preprocess(v3,abs_seconds3);
save v_interp1.mat v_interp1
save v_interp2.mat v_interp2
save v_interp3.mat v_interp3


%% ��������Ԥ�����������ʼ�����˶�ѧƬ��
data_chip_feature1 = divide_into_frags(v_interp1,1); % ��ɸ���Ƭ�ε���������ÿ����һ��Ƭ�ε����������Լ���Դ��λ����Ϣ��
% data_chip_feature��������ʾ��ɸ��ʣ��Ƭ������
data_chip_feature2 = divide_into_frags(v_interp2,2); % 1��ʾ��Դ�������ļ�1
data_chip_feature3 = divide_into_frags(v_interp3,3);
% �������ļ��ĳ�ɸƬ�εģ�����������������һ��
data_chip_feature = [data_chip_feature1;data_chip_feature2;data_chip_feature3];


%  �ɳ�ɸƬ������ֵ����������ɷַ���
[main_feature_matrix,V_feature] = main_feature_analyze(data_chip_feature);


% DBSCAN��ξ��ྫɸƬ�Σ�ɸ��������ȺƬ�Σ��쳣Ƭ�Σ�
final_frags = precise_choose(main_feature_matrix);


% �����յ�Ƭ��final_frags��spss.mat���в�ξ���(��excel��)
save final_frags.mat final_frags
disp(['��ɸƬ���Ѿ����浽final_frags.mat�У���ǰ��spss���в�ξ��࣬��ɺ��뽫�������hierarchical_cluster_result.mat'])
% ��ξ�����ֱ��ճ������ߵ�hierarchical_cluster_result.mat�ļ����к����Ĺ�������Ƭ��ɸѡ
disp('final_frags �ĵ�1������Դ��2:4����λ�ã�5:10������')
disp('hierarchical_cluster_result ��ǰ10����final_frags����11���ǲ�ξ�����')

% ����������ѡ��Ƭ�ι�����������
curve_build;