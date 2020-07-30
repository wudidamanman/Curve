% % % DBSCAN���� % % %
function [isvalid, isoutlier]=DBSCAN(pre_fragments,radius,least_points)
cluster = 0;
n=size(pre_fragments,1);
isvalid=zeros(n,1);  % ȫ����ʼ��Ϊ��ȺƬ��
% ���������˶�Ƭ��֮����໥���룬�������
D=pdist2(pre_fragments,pre_fragments);
visited=false(n,1);
isoutlier=false(n,1);
for i=1:n
    if ~visited(i)
        visited(i)=true;
        Neighbors=RegionQuery(i);
        if numel(Neighbors) < least_points
            % ���Ǻ��ĵ㣬����ȺƬ��
            isoutlier(i)=true;
        else
            cluster=cluster+1; % ������������ں��ĵ���Ŀ
            ExpandCluster(i,Neighbors,cluster);
        end
    end 
end
% ��չ��ǰ��
    function ExpandCluster(i,Neighbors,cluster)
        isvalid(i)=cluster;
        k = 1;
        while true
            j = Neighbors(k);
            if ~visited(j)
                visited(j)=true;
                Neighbors2=RegionQuery(j);
                if numel(Neighbors2)>=least_points
                    Neighbors=[Neighbors Neighbors2];   %#ok
                end
            end
            if isvalid(j)==0
                isvalid(j)=cluster;
            end
            k = k + 1;
            if k > numel(Neighbors)
                break;
            end
        end
    end
% �ҵ���Χ������ɸ��뾶�ڵ��ڽ�Ƭ��
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=radius);
    end
end



