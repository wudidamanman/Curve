% % % DBSCAN聚类 % % %
function [isvalid, isoutlier]=DBSCAN(pre_fragments,radius,least_points)
cluster = 0;
n=size(pre_fragments,1);
isvalid=zeros(n,1);  % 全部初始化为离群片段
% 计算所有运动片段之间的相互距离，距离矩阵
D=pdist2(pre_fragments,pre_fragments);
visited=false(n,1);
isoutlier=false(n,1);
for i=1:n
    if ~visited(i)
        visited(i)=true;
        Neighbors=RegionQuery(i);
        if numel(Neighbors) < least_points
            % 则不是核心点，是离群片段
            isoutlier(i)=true;
        else
            cluster=cluster+1; % 聚类类别数等于核心点数目
            ExpandCluster(i,Neighbors,cluster);
        end
    end 
end
% 扩展当前类
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
% 找到周围距离在筛查半径内的邻近片段
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=radius);
    end
end



