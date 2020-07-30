%% ����T<500s�Ĳ�������ľ���S�Ͷ�Ӧ�ٶ�V�����gps�źŶ�ʧ������
function [gps_loss_ind,gps_sec,sum_add_sec] = get_gps_loss(ind_less_than_threshold,abs_seconds,abs_seconds_diff)
load lati_longi_1 % �ļ�1�ľ�γ������

%% ��γ���쳣����Ԥ����
% ���۲췢�־�γ�������ж�ʧΪ0�����������һ��ľ�γ���ݲ�ȫ
ind_0 = find(lati_longi_1==0);
for i =1:length(ind_0)
    lati_longi_1(ind_0(i)) = lati_longi_1(ind_0(i)-1) ;
end

R = 6371; %����뾶��km
phi_x = lati_longi_1(:,1)*pi/180; %��γ�ȱ任Ϊ������Ƕ�
phi_y = lati_longi_1(:,2)*pi/180;

gps_loss_ind = []; % ��ʼ��gps�źŶ�ʧ�ļ������
for i=1:length(ind_less_than_threshold)
    p1 = ind_less_than_threshold(i);
    p2 = ind_less_than_threshold(i)+1;
    distance_earth = R * acos(cos(phi_x(p1)-phi_x(p2))*cos(phi_y(p1))*cos(phi_y(p2))+sin(phi_y(p1))*sin(phi_y(p2)))*1000;
    t = abs_seconds(p2) - abs_seconds(p1);
    v = distance_earth / t;
    flag = (distance_earth > 10) && (v<30);
    if (v>60 || flag==1)
        % 80/3.6=22  �������80km/h
        % �ж�ΪGPS�źŶ�ʧ,���ֵ��������
        gps_loss_ind = [gps_loss_ind ind_less_than_threshold(i)];
    end
end
gps_loss_ind = gps_loss_ind';
gps_sec= abs_seconds_diff(gps_loss_ind); % gps��ʧ�ļ������
sum_add_sec = sum(gps_sec); % ����ʱ������
end