%% ��ȡ��ɸ��Ƭ�ε������ĺ���
% % % % % % % % % % �˶�ѧƬ�ε�������ȡ% % % % % % % % %
function [all_feature_vector,isvalid] = feature_pick(vector_orignal,K)	% K ����ʱ�䳤��
if nargin<2
    K = 10; % ��������뵡��ʱ�䳤�ȣ���Ĭ��Ϊ10
end
 data_preprocessed = vector_orignal;
%%
v_data_preprocesd_m  = data_preprocessed';	%����˲ʱ�ٶ� ��m/s��
% v_data_preprocesd_m = v_data_preprocesd/3.6;	%����˲ʱ�ٶ� 
T_chip =  length(v_data_preprocesd_m); % Ƭ�γ���
T_idle = K;	%����ʱ�䳤��

% % ÿһ�д洢һ���˶�ѧƬ�ε�����
% % �˶�ѧƬ����Ŀ�������� n
% % ���� m ������˶�ѧƬ�εĳ���
% [n,m] = size(sport_frag); 
% ����ÿ��Ƭ�ε��˶�ѧ����ָ��
%%	����
%	���ٶȼ��� vehicle_a
	vehicle_a = v_data_preprocesd_m(2:end) - v_data_preprocesd_m(1:end-1) ;% a = dv/dt
%	Tf_speedup ʱ����� seconds
	Tf_speedup_num = length(find(vehicle_a>0.15));
	Tf_slowdown_num = length(find(vehicle_a<-0.15));
	Tf_stablerun_num = length(find(vehicle_a>=-0.15 & vehicle_a<=0.15));
	%ʱ���
	rate_Tf_speedup = Tf_speedup_num/length(vehicle_a) + eps;
	rate_Tf_slowdown = Tf_slowdown_num/length(vehicle_a) + eps;
	rate_Tf_stablerun = (Tf_stablerun_num - T_idle)/length(vehicle_a) + eps;		%����Ӧ��Ҫ���ǵ���ʱ��Ŷ�
	rate_Tf_stablestop = (T_idle)/length(vehicle_a) + eps;	%����ʱ���
	
%%	����
	vehicle_S = sum(v_data_preprocesd_m) + eps;	%��λm
	
	
%%	�ٶ�����	m/s
	vehicle_v_max = max(v_data_preprocesd_m) + eps;	%����ٶ�
	vehicle_v_mean = vehicle_S/length(v_data_preprocesd_m) + eps;	%ƽ���ٶ�
	%vehicle_v_mean_real = vehicle_S/((length(v_data_preprocesd_m)-T_daisu) + eps);	%ƽ����ʻ�ٶ�
    vehicle_v_mean_real = vehicle_S/((T_chip-T_idle) + eps);	%ƽ����ʻ�ٶ�
	vehicle_v_standard = sqrt(1/(T_chip)* sum((v_data_preprocesd_m-vehicle_v_mean).^2)) + eps;	%��Ƭ�α�׼��

%%	�������� m/s^2
	vehicle_speedup_max = max(vehicle_a) + eps;	%�����ٶ�
	vehicle_speedup_temp = vehicle_a(find((vehicle_a>0.15)));
    if (Tf_speedup_num >0)
        vehicle_speedup_mean = sum(vehicle_a(find((vehicle_a>0.15))))/Tf_speedup_num + eps;	%ƽ�����ٶ�
        vehicle_speedup_std = sqrt(1/(Tf_speedup_num)* sum((vehicle_speedup_temp -vehicle_speedup_mean).^2))+ eps;	%��Ƭ�� ���ٶȱ�׼��
    else
        vehicle_speedup_mean = 0  + eps;	%ƽ�����ٶ�
        vehicle_speedup_std = 0  + eps;
    end
    
    %----------------------------------------------------------------------
	vehicle_slowdown_max = abs(min(vehicle_a)) + eps;	%�����ٶ� ����ֵ
	vehicle_slowdown_temp = vehicle_a(find((vehicle_a< -0.15))) + eps;
    if (Tf_slowdown_num >0)
        vehicle_slowdown_mean = sum(vehicle_a(find((vehicle_a>0.15))))/(Tf_speedup_num + eps);	%ƽ�����ٶ�
        vehicle_slowdown_std = sqrt(1/(Tf_speedup_num + eps)* sum((vehicle_slowdown_temp -vehicle_slowdown_mean).^2))  + eps;	%��Ƭ�� ���ٶȱ�׼��
    else
        vehicle_slowdown_mean = 0 + eps;	%ƽ�����ٶ�
        vehicle_slowdown_std = 0 + eps;
    end
% 	vehicle_slowdown_mean = abs( sum(vehicle_a(find((vehicle_a<-0.15))))/Tf_slowdown_num );	%ƽ�����ٶ�
% 	vehicle_slowdown_std = sqrt(1/(Tf_slowdown_num)* sum((vehicle_slowdown_temp -vehicle_slowdown_mean).^2));	%��Ƭ�� ���ٶȱ�׼��
	
%%	�ٶȷֶ�����
%	vehicle_v_0to10 = find(v_data_preprocesd_m>0 & v_data_preprocesd_m =<10/3.6);	% 0��10km/h
	vehicle_v_divide_Num = 9;
	vehicle_v_divide_T = zeros(1,vehicle_v_divide_Num);
	for i = 1:vehicle_v_divide_Num-1	%���� 0 to 80����ʱ�����
		vehicle_v_divide_T(i) = length( find(v_data_preprocesd_m>(10*(i-1)/3.6) & v_data_preprocesd_m <=(10*i/3.6)) ) + eps;
	end
	vehicle_v_divide_T(vehicle_v_divide_Num) = length( find(v_data_preprocesd_m > (80/3.6))) + eps;
	vehicle_v_divide_rate = vehicle_v_divide_T/(T_chip-T_idle) + eps;	%	���������
	
%%	ƴ����������

% [����ٶ� ƽ���ٶ� ƽ����ʻ�ٶ� �ٶȱ�׼�� ...   x4
%  �����ٶ� ƽ�����ٶ� ���ٶȱ�׼�� �����ٶ� ƽ�����ٶ� ���ٶȱ�׼�� ...    x6
            %  ����ʱ��� ����ʱ��� ����ʱ���] x3
            % [������ת�� ���ֵ ƽ��ֵ ��׼�� Ť�ذٷֱ� ˲ʱ�ͺ� ����̤�忪�� ��ȼ�� ���������ɰٷֱ� ������] ; 7*3 ��
% [��ʻ���� ��ʻʱ�� ����ʱ�� ����ʱ�� ����ʱ�� ����ʱ��]   x6
all_feature_vector = [vehicle_v_max vehicle_v_mean vehicle_v_mean_real vehicle_v_standard    ...
	vehicle_speedup_max vehicle_speedup_mean vehicle_speedup_std vehicle_slowdown_max vehicle_slowdown_mean ...
     vehicle_S	T_chip Tf_speedup_num Tf_slowdown_num Tf_stablerun_num  T_idle     ...
];

% ���Ƭ�����쳣�������ֵ����Ϊ��ЧƬ��ɾ��
temp = length(find(all_feature_vector>8000));
if temp~=0
    isvalid = 0; % Ƭ����Ч��ɾ��
else 
    isvalid = 1;
end