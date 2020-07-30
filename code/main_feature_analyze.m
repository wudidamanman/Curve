% % % % % % % % % % ���ɷַ���% % % % % % % % %
%% �����ɸƬ�ε�����������������ɷ�
function [main_feature_matrix, V_feature] = main_feature_analyze(matrix_orignal)	
feature = matrix_orignal(:,5:19); % ����15�в�����������������
%% ����һ��m*n�ľ��� m��������������˶�Ƭ��������n��ָ���������������Ŀ
x = feature + eps; % ��ֹ�нӽ���0��ֵʹ�ú����������NaN
[n,p] = size(x);  % n������������p��ָ�����

%% ��һ����������x��׼��
% ����������ؾ���
R = corrcoef(x);

%% �ڶ���������R������ֵ����������

[V_spec,D_lamda] = eig(R);  % V ������������  D ����ֵ���ɵĶԽǾ���

V_spe = fliplr(V_spec); % ��Ϊ������ֵ��Ӧ��������������ǰ��


%% ���������������ɷֹ����ʺ��ۼƹ�����
lambda = diag(D_lamda);  % diag�������ڵõ�һ����������Խ���Ԫ��ֵ(���ص���������)
lambda = lambda(end:-1:1);  % ��Ϊlambda�����Ǵ�С������ģ����ǽ������ͷ
contribution_rate = lambda / sum(lambda);  % ���㹱����
cum_contribution_rate = cumsum(lambda)/ sum(lambda);   % �����ۼƹ�����  cumsum�����ۼ�ֵ�ĺ���
contribution_rate = contribution_rate * 100;
cum_contribution_rate  = cum_contribution_rate *100;

%% ������������Ҫ�����ɷֵ�ֵ

% for i =1:p
%     if(cum_contribution_rate(i) >85 )
%         m = i;
%         break
%     end
% end
m = 6; % ���۲죬3���ļ��е���Ҫ5�����ɷ־Ϳ��Դﵽ85%�����е���Ҫ6������Ϊͳһ����ѡ6��
V_feature = V_spe(:,1:m);
% F = zeros(n,m);  %��ʼ���������ɷֵľ���ÿһ����һ�����ɷ֣�
for i = 1:m
    ai = V_spe(:,i)';   % ����i����������ȡ������ת��Ϊ������
    ac = repmat(ai,n,1);   % ������������ظ�n�Σ�����һ��n*p�ľ���
    main_feature_matrix(:, i) = sum(ac .* x, 2);  % ע�⣬�Ա�׼������������Ȩ�غ�Ҫ����ÿһ�еĺ�
end
main_feature_matrix = [matrix_orignal(:,1:4) main_feature_matrix];  % ���ﻹ��Ҫ����Դ��λ����Ϣ���ϣ�����1:3��
disp(['��ɸƬ������ֵ��������ɷַ����Ѿ����'])
end
