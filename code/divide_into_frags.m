% ��״̬�������˶�Ƭ��
% �����ٶ�
% �����ɸ���Ƭ�ε���������ÿ����һ��Ƭ�ε�����������
function data_chip_feature = divide_into_frags(v_interp,from) 
state = 0; % ��ʼ״̬
tf = 2; % �����ٶ����� m/s
num = 1;
vehicle_v = v_interp;
length_vehicle_v = length(vehicle_v);
for i = 1:length_vehicle_v
    if state == 0 % ״̬Ϊ0���ҵ�����㣬���ٶ�С��2m/s�ĵ�һ����
        if vehicle_v(i) < tf  
            state = 1; % �ҵ��������������״̬Ϊ1
            pre_frag_ind(num) = i;
            num = num +1;
        end
    end
    if (state == 1)
        if (vehicle_v(i)) >= tf % ״̬Ϊ1�����ٶȴ���2m/s�ĵ�һ����
            state = 0; % ��ȥ��0
            pre_frag_ind(num) = i;
            num = num +1;
        end
    end
end

% ��ɸǰ�����˶�Ƭ����Ŀ
pre_frag_num = (length(pre_frag_ind)-1)/2;
disp(['��ɸǰ��⵽��Ƭ�������ǣ�',num2str(pre_frag_num)])

num_for = 0;
num_Tf_dt = 0;
data_chip_feature = zeros(length(pre_frag_num),19); % ��1��ʾƬ����Դ�� 2:4����Ƭ�������յ��λ�������� 5:19��������
data_chip_feature(:,1) = from; % ��ʾ���������ļ�����Ƭ��
Tf_dt_idle = [];
for i = 1:2:length(pre_frag_ind)-2
    
    Tf_dt_tt = pre_frag_ind(i+2) - pre_frag_ind(i); %Ƭ�εĳ���
    Tf_dt_tm = pre_frag_ind(i+2) - pre_frag_ind(i+1);   %Ƭ�ε��˶�����
    
    if (Tf_dt_tt >= 20 && Tf_dt_tm >= 5)
        % ��ɸ��ѡ���ܳ��ȴ���20���˶����ȴ���5��Ƭ��
        num_Tf_dt = num_Tf_dt + 1;    % ��ɸ�����ЧƬ����Ŀ
        Tf_dt_idle_temp = pre_frag_ind(i+1) - pre_frag_ind(i); % Ƭ�εĵ��ٳ���
        if (Tf_dt_idle_temp > 180)
            % ����ʱ�䳤��180s
            pre_frag_ind(i) = pre_frag_ind(i+1) - 180;
        end
        Tf_dt_idle_temp = pre_frag_ind(i+1) - pre_frag_ind(i); % Ƭ�ε��µ��ٳ���
        Tf_dt_idle = [Tf_dt_idle Tf_dt_idle_temp];   
        Tf_dt(num_Tf_dt) = pre_frag_ind(i+2) - pre_frag_ind(i);     %�����Ƭ����ʱ��
        data_chip = v_interp(pre_frag_ind(i):pre_frag_ind(i+2) -1); %��Ƭ�ε��ٶ�����,m/s
        
        
        % ��ɸ���Ƭ�Σ�����ȡ�������ٽ������ɷַ�����Ȼ����DBSCAN�ܶȾ��ྫɸ������ȺƬ��
        [data_chip_feature(num_Tf_dt,5:19),isvalid] = feature_pick(data_chip,Tf_dt_idle(num_Tf_dt));  %����Ƭ�ε��������ؾ���
        data_chip_feature(num_Tf_dt,2:4)=[pre_frag_ind(i) pre_frag_ind(i+1)  pre_frag_ind(i+2)]; % ��������������������������������
        data_chip_feature(:,1) = from; % ��ʾ���������ļ�1��Ƭ��
        if isvalid == 0
            num_Tf_dt = num_Tf_dt -1; % Ƭ����Ч��ɾ��
            data_chip_feature(end,:) = []; % ɾ����ǰƬ�ε��������������һ�У�
        end
        
    end
end

disp(['��ɸ��ʣ��Ƭ�������ǣ�',num2str(size(data_chip_feature,1))])
end