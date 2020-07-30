% 本函数用于把三个文件的日期时间转换为类似于UTC时间的绝对秒，以便于检测时间不连续的点
% 下面的脚本是导入excel中日期数据时自动生成的，只有%% 转化为类似于UTC时间的绝对秒 和%% 去掉最后三个0是自己写的程序
% 将16行的file1改为file2,最后一行改为save abs_seconds2.mat即可得到文件2的绝对秒

%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file1.xlsx
%    工作表: 原始数据1
%
% 要扩展代码以供其他选定数据或其他电子表格使用，请生成函数来代替脚本。

% 由 MATLAB 自动生成于 2019/09/20 10:07:46

%% 导入数据
[~, ~, raw] = xlsread('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file1.xlsx','原始数据1','A2:A185726');
% [~, ~, raw] = xlsread('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file2.xlsx','原始数据2','A2:A145826');
% [~, ~, raw] = xlsread('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file3.xlsx','原始数据3','A2:A164915');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,1);

%% 将导入的数组分配给列变量名称
date = cellVectors(:,1);

%% 去掉最后三个0
date_data_temp = raw;
for i = 1:length(raw)
    date_data_temp{i} = date_data_temp{i}(1:end-5);
end

%% 转化为类似于UTC时间的绝对秒
[Y,M,D,H,MI,S] = datevec(date_data_temp);
abs_seconds1 = S + MI*60 + H * 60^2 + D*24*60^2;     %假定每个月的第一点凌晨00.00.00秒为时间零
% abs_seconds2 = S + MI*60 + H * 60^2 + D*24*60^2;     %假定每个月的第一点凌晨00.00.00秒为时间零
% abs_seconds3 = S + MI*60 + H * 60^2 + D*24*60^2;     %假定每个月的第一点凌晨00.00.00秒为时间零

%% 清除临时变量
clearvars raw cellVectors;

%% 保存
save abs_seconds1.mat abs_seconds1  % 不写后面这个就会把当前程序的所有变量存进去哦
% save abs_seconds2.mat abs_seconds2  
% save abs_seconds3.mat abs_seconds3