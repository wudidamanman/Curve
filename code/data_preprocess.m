%% ����Ԥ����
% ���ڵ���500s�ļ�����������,ֱ���ж���Щ��������Ϩ��ͣ����������ʱ�䲻����
% �ж�Ϊ����Ϩ��ͣ���ĵ����ں�������쳣���ٶ�ʱ�Ķ��գ���Щ����Ȼ������쳣���ٶ�ֵ����ȴ��Ӧ�ó��ֵ�����
% ��Ϊ����ʱ����ǹ������ߵ���Ҫ���أ����ڹ����������ߵĵ������ݱ�������ʵ��������
% ���ܰ�ͣ��������Ϊ���٣�����ɹ������߼��㲻����

function v_interp = data_preprocess(v,abs_seconds)
v_speed = v/3.6; % ���٣�m/s
abs_seconds_diff = abs_seconds(2:end) - abs_seconds(1:end - 1) - 1; % ���㲻����ʱ����(������Ĳ��)��������Ϊ0
Threshold = 500; % ����������ĺ������������ֵ
ind_large_than_threshold = find(abs_seconds_diff >= Threshold); % ͣ��Ϩ��
ind_less_than_threshold = find(abs_seconds_diff <= Threshold & abs_seconds_diff >=2); % [2,500)s�ļ��������Ϩ���ʧ
ind_break = [ind_less_than_threshold ;ind_large_than_threshold]; 
disp(['ʱ�䲻����������Ϊ��',num2str(size(ind_break,1))])

[sort_dis_table] = distance_break_point(ind_break,abs_seconds); % �˺������н������excel���������жϵ����ռ�ȱ�ͼ
% Ѱ��GPS��ʧ����
[gps_loss_ind,gps_sec,sum_add_sec] = get_gps_loss(ind_less_than_threshold,abs_seconds,abs_seconds_diff);
disp(['ʱ�䲻������������GPS��ʧ������Ϊ��',num2str(size(gps_loss_ind,1))])
disp(['ʱ�䲻�����������ڳ�ʱ��Ϩ��ͣ��������Ϊ��',num2str(size(ind_break,1)-size(gps_loss_ind,1))])
% ��ȫ��ʧ�ٶ�
[v_interp,abs_sec_interp] = gps_interp(v_speed,sum_add_sec,gps_loss_ind,abs_seconds,gps_sec);


% ������ٶ��쳣ֵ
v_interp = acc_abnormal(v_interp,abs_sec_interp);

disp('����Ԥ�������')
end