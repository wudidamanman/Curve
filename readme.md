2019年第十六届华为杯研究生数学建模竞赛D题，论文，代码和中间结果图（获得全国三等奖） main.m 是主程序

其他功能均被封装为子函数，被主函数调用

附件的所有图像均可由源码生成，但由于绘图过多耗时很长，所以得到图像后我们将绘图部分注释掉了

代码执行流程：

准备工作： 把三个文件的日期时间转换为类似于UTC时间的绝对秒，便于后续检测时间不连续点；补齐少数几个缺失的经纬度数据，便于判定是否是GPS信号丢失时使用

数据预处理 ：检测时间不连续点----判断是正常停车熄火丢失数据还是GPS信号丢失导致丢失数据----补齐GPS丢失速度和时间----平滑加速度毛刺（前面判断出来是正常熄火的点的毛刺不予处理）

用状态机提取运动片段----初筛片段（段长小于20s或运动时间小于5s的片段被筛除）----对于怠速长度大于180s的片段，将片段起点向后推移直到怠速时长等于180s----提取剩余运动片段的特征，构建特征向量

（以上操作对三个文件的数据独立进行，以下操作将三个文件合并处理，注意合并的是来自三个文件的片段的特征向量）

将总的特征向量进行主成分分析，得到总贡献率大于85%的前6个主成分

精筛片段： 将主成分分析得到的所有片段的6个主成分进行基于密度的DBSCAN聚类，调整聚类半径和最少点数，使片段被聚为1类，噪声点即为离群片段，被筛除

将精筛得到的最终片段的6个主成分送入SPSS进行层次聚类，聚为3类，并将聚类结果返回到MATLAB

根据类别大小，以不同概率从三个类别的候选片段中，通过轮盘法抽选最具代表性的运动片段构建最终的工矿曲线 其中各类别的候选片段由距离聚类中心最近的 10%*该类别片段总数 个片段构成 考虑到抽取的随机性，共绘制了5条工况曲线