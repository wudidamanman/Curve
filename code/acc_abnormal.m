function v_interp = acc_abnormal(v_interp,abs_sec_interp)
interval = abs_sec_interp(2:end) - abs_sec_interp(1:end - 1)- 1;
mkdir('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\加速度异常点处理前后对比图')

% 循环处理10次，以加重平滑毛刺的效果
for j=1:10
    % 检测加速度异常点
    accele = v_interp(2:end) - v_interp(1:end - 1);
    ind_excep = [];
    ind_might_abnor = find(abs(accele)>8);
    for j=1:length(ind_might_abnor)
        if interval(j)<5 % 如果间隔太大则认为是停车熄火，而不是加速度毛刺（测量异常）
            ind_excep = [ind_excep ind_might_abnor(j)];
        end
    end
    disp(['第',num2str(j),'次平滑后剩余加速度异常点个数：'])
    disp(size(ind_excep,2))
    
    % 处理加速度异常点
    for i =1:length(ind_excep)
        old_ind = [ind_excep(i)-19:ind_excep(i) ind_excep(i)+2:ind_excep(i)+20];
        old_v_40s = v_interp(old_ind);
        new_ind = [ind_excep(i)-19:ind_excep(i)+20];
        new_v_40s = spline(old_ind,old_v_40s,new_ind);
        new_v_40s(new_v_40s<0)=0;
        new_v_40s(new_v_40s>110)=110;
        v_interp(new_ind) = new_v_40s;

%         % 绘制加速度异常点处理前后的对比图，取消注释可运行，取消注释可运行，对文件1数据的运行结果保存在附件中
%         figure(i)
%         subplot(211)
%         plot(-19:19,old_v_40s,'ko');
%         hold on
%         plot(1,old_v_40s(21),'r*')
%         hold off
%         text(-5,old_v_40s(21)+1,'异常速度')
%         title('加速度异常点平滑前')
%         
%         ylabel('速度  m/s')
%         grid on
%         subplot(212)
%         plot(-19:20,new_v_40s,'ko');
%         hold on
%         plot(1,new_v_40s(21),'g*')
%         hold off
%         text(2,new_v_40s(21)+1,'新的速度')
%         title('加速度异常点平滑后')
%         ylabel('速度  m/s')
%         grid on
%         % 保存图像
%         saveas(gcf,['D:\Program Files\MATLAB\R2016b\bin\Modelling\src\加速度异常点处理前后对比图\',strcat('fig', num2str(i) , '.jpg')]);
%         close % 关闭当前图形
        
    end
end  % 在此处设置断点可以得到D:\Program Files\MATLAB\R2016b\bin\Modelling\src\加速度异常点处理前后对比图中的22张图
disp(['加速度异常值（毛刺）已经处理完毕'])
end