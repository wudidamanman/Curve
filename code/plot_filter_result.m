% % % 画出聚类筛除结果 % % %
function plot_filter_result(pre_fragments, C_num)

    k=max(C_num);

    Colors=hsv(k);

    Legends = {};
    for i=0:k
        Xi=pre_fragments(find(C_num==i),:);
        if i~=0
            Style = 'x';
            MarkerSize = 4;
            Color = Colors(i,:);
            Legends{end+1} = ['Valid Fragments #' num2str(i)];
        else
            % 噪声片段
            Style = 'o';
            MarkerSize = 4;
            Color = [0 0 0];
            if ~isempty(Xi)
                Legends{end+1} = 'Outlier Fragments';
            end
        end
        if ~isempty(Xi)

            plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
            % 横轴：第一主成分，纵轴：第二主成分
        end
        hold on;
    end
    hold off;
    %axis equal;
    grid on;
    legend(Legends);
    legend('Location', 'NorthEastOutside');

end