function v_interp = acc_abnormal(v_interp,abs_sec_interp)
interval = abs_sec_interp(2:end) - abs_sec_interp(1:end - 1)- 1;
mkdir('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\���ٶ��쳣�㴦��ǰ��Ա�ͼ')

% ѭ������10�Σ��Լ���ƽ��ë�̵�Ч��
for j=1:10
    % �����ٶ��쳣��
    accele = v_interp(2:end) - v_interp(1:end - 1);
    ind_excep = [];
    ind_might_abnor = find(abs(accele)>8);
    for j=1:length(ind_might_abnor)
        if interval(j)<5 % ������̫������Ϊ��ͣ��Ϩ�𣬶����Ǽ��ٶ�ë�̣������쳣��
            ind_excep = [ind_excep ind_might_abnor(j)];
        end
    end
    disp(['��',num2str(j),'��ƽ����ʣ����ٶ��쳣�������'])
    disp(size(ind_excep,2))
    
    % ������ٶ��쳣��
    for i =1:length(ind_excep)
        old_ind = [ind_excep(i)-19:ind_excep(i) ind_excep(i)+2:ind_excep(i)+20];
        old_v_40s = v_interp(old_ind);
        new_ind = [ind_excep(i)-19:ind_excep(i)+20];
        new_v_40s = spline(old_ind,old_v_40s,new_ind);
        new_v_40s(new_v_40s<0)=0;
        new_v_40s(new_v_40s>110)=110;
        v_interp(new_ind) = new_v_40s;

%         % ���Ƽ��ٶ��쳣�㴦��ǰ��ĶԱ�ͼ��ȡ��ע�Ϳ����У�ȡ��ע�Ϳ����У����ļ�1���ݵ����н�������ڸ�����
%         figure(i)
%         subplot(211)
%         plot(-19:19,old_v_40s,'ko');
%         hold on
%         plot(1,old_v_40s(21),'r*')
%         hold off
%         text(-5,old_v_40s(21)+1,'�쳣�ٶ�')
%         title('���ٶ��쳣��ƽ��ǰ')
%         
%         ylabel('�ٶ�  m/s')
%         grid on
%         subplot(212)
%         plot(-19:20,new_v_40s,'ko');
%         hold on
%         plot(1,new_v_40s(21),'g*')
%         hold off
%         text(2,new_v_40s(21)+1,'�µ��ٶ�')
%         title('���ٶ��쳣��ƽ����')
%         ylabel('�ٶ�  m/s')
%         grid on
%         % ����ͼ��
%         saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\���ٶ��쳣�㴦��ǰ��Ա�ͼ\',strcat('fig', num2str(i) , '.jpg')]);
%         close % �رյ�ǰͼ��
        
    end
end  % �ڴ˴����öϵ���Եõ�D:\Program Files\MATLAB\R2016b\bin\Modelling\src\���ٶ��쳣�㴦��ǰ��Ա�ͼ�е�22��ͼ
disp(['���ٶ��쳣ֵ��ë�̣��Ѿ��������'])
end