%��������ʱ�䲻������ľ��룬�۲����ֲ����õ����������ڻ��������жϵ����ռ�ȱ�ͼ
function [sort_dis_table] = distance_break_point(ind_break,abs_seconds)
load lati_longi_1 % �ļ�1�ľ�γ������
% ���۲췢�־�γ�������ж�ʧΪ0�����������һ��ľ�γ���ݲ�ȫ
ind_0 = find(lati_longi_1==0);
for i =1:length(ind_0)
    lati_longi_1(ind_0(i)) = lati_longi_1(ind_0(i)-1) ;
end

R = 6371; %����뾶��km
phi_x = lati_longi_1(:,1)*pi/180; %��γ�ȱ任Ϊ������Ƕ�
phi_y = lati_longi_1(:,2)*pi/180;   
distance_earth = []; 
V =[];

for i =1: length(ind_break)
    p1 = ind_break(i);
    p2 = ind_break(i)+1;
    temp = real( R * acos(cos(phi_x(p1)-phi_x(p2))*cos(phi_y(p1))*cos(phi_y(p2))+sin(phi_y(p1))*sin(phi_y(p2)))*1000); % ��
    T = abs_seconds(p2) - abs_seconds(p1); % ��
    distance_earth = [distance_earth temp];
    v_cal = temp / T; % �ٶȣ�m/s
    V =[V v_cal];
end
sort_dis_table = (sort(distance_earth)/1000)'; % km
end