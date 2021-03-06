% % % 工矿曲线构建 % % %
%% 从每个类选出代表性片段组合得到工矿曲线（1200s）
function curve_build
load hierarchical_cluster_result
load v_interp1
load v_interp2
load v_interp3
X = hierarchical_cluster_result; % 1列是来源，2:3列是位置，4:9是特征，10是聚类结果
c1 = [];
c2 = [];
c3 = [];
for i =1:size(X,1)
    % 最终片段的主成分特征和聚类结果(第11列)
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

%% 画出精筛后，通过层次聚类得到的三类运动片段（此段绘图代码取消注释可运行生成附件图，但需要运行20分钟）
% 第一类
% folder1 = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\层次聚类得到的第一类运动片段\';
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第一类运动片段')
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第一类运动片段')
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第一类运动片段')
%         saveas(gcf,[folder1,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
% end
%
% % 第二类
% folder2 = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\层次聚类得到的第二类运动片段\';
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第二类运动片段')
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第二类运动片段')
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第二类运动片段')
%         saveas(gcf,[folder2,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
% end
%
% % 第三类
% folder3 = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\层次聚类得到的第三类运动片段\';
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第三类运动片段')
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第三类运动片段')
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
%         text((MID-2)/2,HEIGHT/2, '怠速','fontsize',18)
%         text((MID+END-2)/2,HEIGHT/2, '运动','fontsize',18)
%         set(gca,'xtick',[],'xticklabel',[])
%         set(gca,'ytick',[],'yticklabel',[])
%         title('第三类运动片段')
%         saveas(gcf,[folder3,strcat('frag',num2str(i),'.jpg')]);
%         close
%     end
% end

%% 计算三个类的聚类中心和候选片段
data1 = c1(:,5:10);
center1 = mean(data1);
% 得到候选片段(每个类挑选10%)
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
%% 随机挑选构建工矿曲线的片段
% load repre_frag.mat
load v_interp1
load v_interp2
load v_interp3
folder = 'D:\Program Files\MATLAB\R2016b\bin\Modelling\src\工矿曲线\';
mkdir(folder )


p1 = size(c1,1)/ size(X,1); % 从第一类片段选择的概率
p2 = size(c2,1)/ size(X,1);
p3 = size(c3,1)/ size(X,1);
for s=1:5 % 构建5个工矿曲线
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
            disp(['用于构建工况曲线的运动片段已经保存在repre_frag.mat中'])
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
            disp(['用于构建工况曲线的运动片段已经保存在repre_frag.mat中'])
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
            disp(['用于构建工况曲线的运动片段已经保存在repre_frag.mat中'])
            %             return;
            break
        end
        continue
    end
    if (time>1200)
%         save repre_frag.mat repre_frag
        disp(['用于构建工况曲线的运动片段已经保存在repre_frag.mat中'])
        %     return;
        break
    end
end
j=0;
figure(s)
for i =1:size(repre_frag,1)
    length_of_frag =(repre_frag(i,4)-repre_frag(i,2))+1;
    if (repre_frag(i,1)==1) % 来自文件1
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
title('工况曲线(绿×为片段起点，红*为片段终点)')
% text(800,15,'绿×为片段起点，红*为片段终点')
saveas(gcf,[folder,strcat('curve',num2str(s),'.jpg')]);
close % 关闭当前图形
end
disp(['工况曲线绘制完成'])
end