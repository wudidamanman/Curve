%% ʹ�÷ֶ�����������ֵ���������ֵ����GPS�źŶ�ʧ���µĶ�ʧ���ٲ�ȫ
% ��������ԭʼ���ݵ�ʱ�䲻�����㣬�����������Ϊͣ��Ϩ���GPS�źŶ�ʧ�������
% �о�׼��
% �ȿ�ʱ����T
% ��T>500s��һ����Ϩ��ͣ������T<=500s��������ͣ����Ҳ�������źŶ�ʧ��
% ����T<=500s���ٿ�����˵�ľ���S
% ��S<10m,һ����ͣ������S>10m���������źŶ�ʧ��Ҳ������һ�����ݿ�ʼ�����������ٶ�V�ж�
% V=S/T(V���ǳ���)����V>30m/s(108km/h),��һ������һ�����ݿ�ʼ��������GPS�źŶ�ʧ����Ϊ������������80km/h

function [v_interp,abs_sec_interp] = gps_interp(v_speed,sum_add_sec,gps_loss_ind,abs_seconds,gps_sec)
v_interp = zeros(1,length(v_speed) + sum_add_sec); % ��ʼ������ֵ�ĳ���
abs_sec_interp = zeros(size(v_interp)); % �µľ���ʱ�䣬���ڼ����ٶ�ë��
added_sec = 0; % �Ѿ���ӵ�����
start_indx = gps_loss_ind(1);
end_indx = start_indx;
v_interp(1:start_indx) = v_speed(1:start_indx); % �ٶ�
abs_sec_interp(1:start_indx)= abs_seconds(1:start_indx); % ʱ��

mkdir('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\�ٶȲ�ֵǰ��Ա�ͼ');

% ȡ��ʧ������Ҹ�n���㣬nΪ��ʧ����(�������)����Ԥ��ڵ㣺��ֵ�ڵ� = 1:2
for j = 1:length(gps_loss_ind) - 1
    for i = 1:length(v_speed)
        if (i == gps_loss_ind(j))          
            old_ind = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)+gps_sec(j) ]; % ��ͼ��
            old_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j),gps_loss_ind(j)+gps_sec(j)+1:gps_loss_ind(j)+2*gps_sec(j) ];  % ��ֵ��
            new_ind = [gps_loss_ind(j)+1:gps_loss_ind(j)+ gps_sec(j) ]; % ��ֵ��
            new_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j) + 2*gps_sec(j)]; % ��ͼ��
            % �ٶ�
            new_v_speed = spline(old_ind_,v_speed(old_ind),new_ind) + randn; %�����ٶ��Ŷ�������̫���ڹ⻬;
            new_v_speed( new_v_speed<0) = 0; % ���ܲ��벻���ܵĸ�ֵ
            new_v_speed( new_v_speed>110) = 110; % ���ܲ��벻���ܵ��ش�ֵ
            new_abs_sec = abs_seconds(gps_loss_ind(j))+1 : abs_seconds(gps_loss_ind(j))+gps_sec(j);    
            
%             % �����ٶȲ�ֵǰ���ͼ��ȡ��ע�Ϳ����У����ļ�1���ݵ����н�������ڸ�����
%             figure(j)
%             subplot(2,1,1)
%             plot(old_ind,v_speed(old_ind),'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(gps_loss_ind(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS�źŶ�ʧ�ٶȲ�ֵǰ')
%             subplot(2,1,2)
%             plot(new_ind_,[v_speed(gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)); new_v_speed'; v_speed(gps_loss_ind(j)+1:gps_loss_ind(j)+gps_sec(j))],'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(new_ind,new_v_speed,'g*')
%             plot(gps_loss_ind(j)+gps_sec(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS�źŶ�ʧ�ٶȲ�ֵ��')
%             saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\�ٶȲ�ֵǰ��Ա�ͼ\',strcat('gps_v_interp', num2str(j) , '.jpg')]);
%             close % �رյ�ǰͼ��
            
            v_add_temp = new_v_speed;
            t_add_temp = new_abs_sec;
        end
    end
    
    end_indx = start_indx + gps_sec(j)+ 1; 
    v_interp(start_indx + 1:end_indx - 1) = v_add_temp;
    abs_sec_interp(start_indx + 1:end_indx - 1) = t_add_temp;
    added_sec = added_sec + gps_sec(j) ; % ��ǰ������ʱ�����
    start_indx = gps_loss_ind(j + 1) +  added_sec ;
    v_interp(end_indx:start_indx) = (v_speed((gps_loss_ind(j) + 1):(gps_loss_ind(j + 1))))';
    abs_sec_interp(end_indx:start_indx) = (abs_seconds((gps_loss_ind(j) + 1):(gps_loss_ind(j + 1))))';
end

for j = length(gps_loss_ind)
    start_indx = gps_loss_ind(j) +  added_sec;
    for i = 1:length(v_speed)
        if (i == gps_loss_ind(j))
            old_ind = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)+gps_sec(j) ]; % ��ͼ��
            old_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j),gps_loss_ind(j)+gps_sec(j)+1:gps_loss_ind(j)+2*gps_sec(j)]; % ��ֵ��
            new_ind = [gps_loss_ind(j)+1:gps_loss_ind(j)+ gps_sec(j) ]; % ��ֵ��
            new_ind_ = [gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j) + 2*gps_sec(j)]; % ��ͼ��
            new_v_speed = spline(old_ind_,v_speed(old_ind),new_ind) + randn; %�����ٶ��Ŷ�������̫���ڹ⻬
            new_v_speed( new_v_speed>110) = 110; % ���ܲ��벻���ܵ��ش�ֵ
            new_v_speed( new_v_speed<0) = 0; % ���ܲ��벻���ܵĸ�ֵ
            new_abs_sec = abs_seconds(gps_loss_ind(j))+1 : abs_seconds(gps_loss_ind(j))+gps_sec(j);
            v_add_temp = new_v_speed;
            t_add_temp = new_abs_sec;      
            
% %           % �����ٶȲ�ֵǰ���ͼ��,ȡ��ע�Ϳ����У����ļ�1���ݵ����н�������ڸ�����
%             figure(j)
%             subplot(211)
%             plot(old_ind,v_speed(old_ind),'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(gps_loss_ind(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS�źŶ�ʧ�ٶȲ�ֵǰ')
%             subplot(212)
%             plot(new_ind_,[v_speed(gps_loss_ind(j)-gps_sec(j)+1:gps_loss_ind(j)); new_v_speed'; v_speed(gps_loss_ind(j)+1:gps_loss_ind(j)+gps_sec(j))],'ko')
%             hold on
%             plot(gps_loss_ind(j),v_speed(gps_loss_ind(j)),'r*')
%             plot(new_ind,new_v_speed,'g*')
%             plot(gps_loss_ind(j)+gps_sec(j)+1,v_speed(gps_loss_ind(j)+1),'r*')
%             hold off
%             set(gca,'xtick',[],'xticklabel',[])
%             set(gca,'ytick',[],'yticklabel',[])
%             title('GPS�źŶ�ʧ�ٶȲ�ֵ��')
%             saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\�ٶȲ�ֵǰ��Ա�ͼ\',strcat('gps_v_interp', num2str(j) , '.jpg')]);
%             close % �رյ�ǰͼ��
             
        end
    end
    end_indx = start_indx + gps_sec(j)+ 1; 
    v_interp(start_indx + 1:end_indx - 1) = v_add_temp;
    abs_sec_interp(start_indx + 1:end_indx - 1) = t_add_temp;
    added_sec = added_sec + gps_sec(j) ; % ��ǰ������ʱ�����
    % �ͺ������������Ǹ�ѭ����һ������Ҫ����ԭ�����ٶȺ�ʱ�䣬������j+1
    start_indx = length(abs_sec_interp) ;
    v_interp(end_indx:start_indx) = (v_speed((gps_loss_ind(j) + 1):end))';
    abs_sec_interp(end_indx:start_indx) = (abs_seconds((gps_loss_ind(j) + 1):end))';
end
disp(['GPS��ʧ�ٶ��Ѳ�ȫ���ܹ�������',num2str(sum_add_sec),'��'])
disp(['��ȫGPS��ʧ�ٶȺ��ܼ�¼��',num2str(length(v_interp)),'��'])
end