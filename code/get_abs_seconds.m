% ���������ڰ������ļ�������ʱ��ת��Ϊ������UTCʱ��ľ����룬�Ա��ڼ��ʱ�䲻�����ĵ�
% ����Ľű��ǵ���excel����������ʱ�Զ����ɵģ�ֻ��%% ת��Ϊ������UTCʱ��ľ����� ��%% ȥ���������0���Լ�д�ĳ���
% ��16�е�file1��Ϊfile2,���һ�и�Ϊsave abs_seconds2.mat���ɵõ��ļ�2�ľ�����

%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file1.xlsx
%    ������: ԭʼ����1
%
% Ҫ��չ�����Թ�����ѡ�����ݻ��������ӱ��ʹ�ã������ɺ���������ű���

% �� MATLAB �Զ������� 2019/09/20 10:07:46

%% ��������
[~, ~, raw] = xlsread('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file1.xlsx','ԭʼ����1','A2:A185726');
% [~, ~, raw] = xlsread('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file2.xlsx','ԭʼ����2','A2:A145826');
% [~, ~, raw] = xlsread('D:\Program Files\MATLAB\R2016b\bin\Modelling\src\file3.xlsx','ԭʼ����3','A2:A164915');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,1);

%% ����������������б�������
date = cellVectors(:,1);

%% ȥ���������0
date_data_temp = raw;
for i = 1:length(raw)
    date_data_temp{i} = date_data_temp{i}(1:end-5);
end

%% ת��Ϊ������UTCʱ��ľ�����
[Y,M,D,H,MI,S] = datevec(date_data_temp);
abs_seconds1 = S + MI*60 + H * 60^2 + D*24*60^2;     %�ٶ�ÿ���µĵ�һ���賿00.00.00��Ϊʱ����
% abs_seconds2 = S + MI*60 + H * 60^2 + D*24*60^2;     %�ٶ�ÿ���µĵ�һ���賿00.00.00��Ϊʱ����
% abs_seconds3 = S + MI*60 + H * 60^2 + D*24*60^2;     %�ٶ�ÿ���µĵ�һ���賿00.00.00��Ϊʱ����

%% �����ʱ����
clearvars raw cellVectors;

%% ����
save abs_seconds1.mat abs_seconds1  % ��д��������ͻ�ѵ�ǰ��������б������ȥŶ
% save abs_seconds2.mat abs_seconds2  
% save abs_seconds3.mat abs_seconds3