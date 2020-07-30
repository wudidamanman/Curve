% % % �������߹��� % % %
%% ��ÿ����ѡ��������Ƭ����ϵõ��������ߣ�1200s��
function curve_build
load hierarchical_cluster_result
load v_interp1
load v_interp2
load v_interp3
X = hierarchical_cluster_result; % 1������Դ��2:3����λ�ã�4:9��������10�Ǿ�����
c1 = [];
c2 = [];
c3 = [];
for i =1:size(X,1)
    % ����Ƭ�ε����ɷ������;�����(��11��)
    if (X(i,11)==1)
        c1 = [c1 ; X(i,:)];
    end
    if (X(i,11)==2)
        c2 = [c2 ; X(i,:)];
    end
    if (X(i,11)==3)
        c3 = [c3 ; X(i,:)];
    end
end

%% ������ɸ��ͨ����ξ���õ��������˶�Ƭ�Σ��˶λ�ͼ����ȡ��ע�Ϳ��������ɸ���ͼ������Ҫ����20���ӣ�
% ��һ��
% folder1 = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\��ξ���õ��ĵ�һ���˶�Ƭ��\';
% mkdir(folder1);
% for i=1:length(c1)
%     figure,
%     if(c1(i,1)==1)
%         plot(v_interp1(c1(i,2):c1(i,4)),'k')
%         hold on
%         MID = c1(i,3) - c1(i,2);
%         END = c1(i,4) - c1(i,2)+1;
%         HEIGHT = max(v_interp1(c1(i,2):c1(i,4)));
%         plot([1,1],[0,max(v_interp1(c1(i,2):c1(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp1(c1(i,2):c1(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('��һ���˶�Ƭ��')
%         saveas(gcf,[folder1,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
%     if(c1(i,1)==2)
%         plot(v_interp2(c1(i,2):c1(i,4)),'k')
%
%         hold on
%         MID = c1(i,3) - c1(i,2);
%         END = c1(i,4) - c1(i,2)+1;
%         HEIGHT = max(v_interp2(c1(i,2):c1(i,4)));
%         plot([1,1],[0,max(v_interp2(c1(i,2):c1(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp2(c1(i,2):c1(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('��һ���˶�Ƭ��')
%         saveas(gcf,[folder1,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
%     if(c1(i,1)==3)
%         plot(v_interp3(c1(i,2):c1(i,4)),'k')
%
%         hold on
%         MID = c1(i,3) - c1(i,2);
%         END = c1(i,4) - c1(i,2)+1;
%         HEIGHT = max(v_interp3(c1(i,2):c1(i,4)));
%         plot([1,1],[0,max(v_interp3(c1(i,2):c1(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp3(c1(i,2):c1(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('��һ���˶�Ƭ��')
%         saveas(gcf,[folder1,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
% end
%
% % �ڶ���
% folder2 = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\��ξ���õ��ĵڶ����˶�Ƭ��\';
% mkdir(folder2);
% for i=1:length(c2)
%     figure,
%     if(c2(i,1)==1)
%         plot(v_interp1(c2(i,2):c2(i,4)),'k')
%         hold on
%         MID = c2(i,3) - c2(i,2);
%         END = c2(i,4) - c2(i,2)+1;
%         HEIGHT = max(v_interp1(c2(i,2):c2(i,4)));
%         plot([1,1],[0,max(v_interp1(c2(i,2):c2(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp1(c2(i,2):c2(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('�ڶ����˶�Ƭ��')
%         saveas(gcf,[folder2,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
%     if(c2(i,1)==2)
%         plot(v_interp2(c2(i,2):c2(i,4)),'k')
%         hold on
%         MID = c2(i,3) - c2(i,2);
%         END = c2(i,4) - c2(i,2)+1;
%         HEIGHT = max(v_interp2(c2(i,2):c2(i,4)));
%         plot([1,1],[0,max(v_interp2(c2(i,2):c2(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp2(c2(i,2):c2(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('�ڶ����˶�Ƭ��')
%         saveas(gcf,[folder2,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
%     if(c2(i,1)==3)
%         plot(v_interp3(c2(i,2):c2(i,4)),'k')
%         hold on
%         MID = c2(i,3) - c2(i,2);
%         END = c2(i,4) - c2(i,2)+1;
%         HEIGHT = max(v_interp3(c2(i,2):c2(i,4)));
%         plot([1,1],[0,max(v_interp3(c2(i,2):c2(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp3(c2(i,2):c2(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('�ڶ����˶�Ƭ��')
%         saveas(gcf,[folder2,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
% end
%
% % ������
% folder3 = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\��ξ���õ��ĵ������˶�Ƭ��\';
% mkdir(folder3);
% for i=1:length(c3)
%     figure,
%     if(c3(i,1)==1)
%         plot(v_interp1(c3(i,2):c3(i,4)),'k')
%         hold on
%         MID = c3(i,3) - c3(i,2);
%         END = c3(i,4) - c3(i,2)+1;
%         HEIGHT = max(v_interp1(c3(i,2):c3(i,4)));
%         plot([1,1],[0,max(v_interp1(c3(i,2):c3(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp1(c3(i,2):c3(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('�������˶�Ƭ��')
%         saveas(gcf,[folder3,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
%     if(c3(i,1)==2)
%         plot(v_interp2(c3(i,2):c3(i,4)),'k')
%
%         hold on
%         MID = c3(i,3) - c3(i,2);
%         END = c3(i,4) - c3(i,2)+1;
%         HEIGHT = max(v_interp2(c3(i,2):c3(i,4)));
%         plot([1,1],[0,max(v_interp2(c3(i,2):c3(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp2(c3(i,2):c3(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('�������˶�Ƭ��')
%         saveas(gcf,[folder3,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
%     if(c3(i,1)==3)
%         plot(v_interp3(c3(i,2):c3(i,4)),'k')
%
%         hold on
%         MID = c3(i,3) - c3(i,2);
%         END = c3(i,4) - c3(i,2)+1;
%         HEIGHT = max(v_interp3(c3(i,2):c3(i,4)));
%         plot([1,1],[0,max(v_interp3(c3(i,2):c3(i,4)))],'r','linewidth',1)
%         plot([MID,MID],[0,max(v_interp3(c3(i,2):c3(i,4)))],'r','linewidth',1)
%         plot([END, END],[0,HEIGHT],'r','linewidth',1)
%         hold off
%         text((MID-2)/2,HEIGHT/2, '����','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '�˶�','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('�������˶�Ƭ��')
%         saveas(gcf,[folder3,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
% end

%% ����������ľ������ĺͺ�ѡƬ��
data1 = c1(:,5:10);
center1 = mean(data1);
% �õ���ѡƬ��(ÿ������ѡ10%)
num_choose1 = ceil(size(c1,1) * .1);
distance1 = sum((data1 - center1).^2,2);
[sort_d1, ind1] = sort(distance1);
choose1 =c1(ind1(1:num_choose1),1:4);

data2 = c2(:,5:10);
center2 = mean(data2);
num_choose2 = ceil(size(c2,1) * .1);
distance2 = sum((data2 - center2).^2,2);
[sort_d2, ind2] = sort(distance2);
choose2 =c2(ind2(1:num_choose2),1:4);

data3 = c3(:,5:10);
center3 = mean(data3);
num_choose3 = ceil(size(c3,1) * .1);
distance3 = sum((data3 - center3).^2,2);
[sort_d3, ind3] = sort(distance3);
choose3 =c3(ind3(1:num_choose3),1:4);
%% �����ѡ�����������ߵ�Ƭ��
% load repre_frag.mat
load v_interp1
load v_interp2
load v_interp3
folder = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\��������\';
mkdir(folder )


p1 = size(c1,1)/ size(X,1); % �ӵ�һ��Ƭ��ѡ��ĸ���
p2 = size(c2,1)/ size(X,1);
p3 = size(c3,1)/ size(X,1);
for s=1:5 % ����5����������
time=0;
repre_frag =[];
for i=1:50
    
    rand_number = rand;
    
    
    if rand_number < p2
        temp_rand = ceil(rand * (size(choose2,1)-1)) + 1;
        repre_frag = [repre_frag; choose2(temp_rand,:)];
        time=time+choose2(temp_rand,4)-choose2(temp_rand,2)+1;
        if (time>1200)
%             save repre_frag.mat repre_frag
            disp(['���ڹ����������ߵ��˶�Ƭ���Ѿ�������repre_frag.mat��'])
            return;
        end
        continue
    end
    
    if rand_number < p3
        
        temp_rand = ceil(rand * (size(choose3,1)-1)) + 1;
        repre_frag = [repre_frag; choose3(temp_rand,:)];
        time=time+choose3(temp_rand,4)-choose3(temp_rand,2)+1;
        if (time>1200)
%             save repre_frag.mat repre_frag
            disp(['���ڹ����������ߵ��˶�Ƭ���Ѿ�������repre_frag.mat��'])
            %             return;
            break
        end
        continue
    end
    
    if rand_number < p1
        
        temp_rand = ceil(rand * (size(choose1,1)-1)) + 1;
        repre_frag = [repre_frag; choose1(temp_rand,:)];
        time=time+choose1(temp_rand,4)-choose1(temp_rand,2)+1;
        if (time>1200)
%             save repre_frag.mat repre_frag
            disp(['���ڹ����������ߵ��˶�Ƭ���Ѿ�������repre_frag.mat��'])
            %             return;
            break
        end
        continue
    end
    if (time>1200)
%         save repre_frag.mat repre_frag
        disp(['���ڹ����������ߵ��˶�Ƭ���Ѿ�������repre_frag.mat��'])
        %     return;
        break
    end
end
j=0;
figure(s)
for i =1:size(repre_frag,1)
    length_of_frag =(repre_frag(i,4)-repre_frag(i,2))+1;
    if (repre_frag(i,1)==1) % �����ļ�1
        plot(j:j+length_of_frag-1,v_interp1(repre_frag(i,2):repre_frag(i,4)),'k')
        hold on
        plot(j,v_interp1(repre_frag(i,2)),'gx',j+length_of_frag-1,v_interp1(repre_frag(i,4)),'r*')
        j=j+length_of_frag;
        
    end
    if (repre_frag(i,1)==2)
        plot(j:j+length_of_frag-1,v_interp2(repre_frag(i,2):repre_frag(i,4)),'k')
        hold on
        plot(j,v_interp2(repre_frag(i,2)),'gx',j+length_of_frag-1,v_interp2(repre_frag(i,4)),'r*')
        j=j+length_of_frag;
        
    end
    if (repre_frag(i,1)==3)
        plot(j:j+length_of_frag-1,v_interp3(repre_frag(i,2):repre_frag(i,4)),'k')
        hold on
        plot(j,v_interp3(repre_frag(i,2)),'gx',j+length_of_frag-1,v_interp3(repre_frag(i,4)),'r*')
        j=j+length_of_frag;
        
    end
    
end
hold off
title('��������(�̡�ΪƬ����㣬��*ΪƬ���յ�)')
% text(800,15,'�̡�ΪƬ����㣬��*ΪƬ���յ�')
saveas(gcf,[folder,strcat('curve',num2str(s),'.jpg')]);
close % �رյ�ǰͼ��
end
disp(['�������߻������'])
end