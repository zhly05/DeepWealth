%% 这个脚本用于提取数据特征，两个主要特征：阶段涨幅和振幅均值，并显示在二维空间上看分布
%%
load('G:\StockData\local\2015_07_30.mat');
test_array = StockArrays.sh600007;
%%
time_res = 5 * 60; %(s)
time_tic = [TimeStr2Sec('09:30:01'):TimeStr2Sec('11:30:00'),TimeStr2Sec('13:00:01'):TimeStr2Sec('15:00:00')];
time_mat = reshape(time_tic,time_res,[]);

fnames = fieldnames(StockArrays)

stat_eng = [];
stat_slope = [];
for i = 1:length(fnames)
    test_array = StockArrays.(fnames{i});
    time_array = test_array.timearray;
    pri_array = test_array.items(:,3)/test_array.items(1,3);

    pri_mat = interp1([-10;time_array],[1;pri_array],time_mat);
    detr_pri = detrend(pri_mat);
    temp = sum(detr_pri.^2)/time_res;
    s_stat_eng = temp.^0.5;
    s_stat_slope = (pri_mat(end,:) - detr_pri(end,:) - pri_mat(1,:) + detr_pri(1,:));
    stat_eng = [stat_eng;s_stat_eng];
    stat_slope = [stat_slope;s_stat_slope];
    disp(fnames{i})
end
%%
subplot(4,2,1);
plot(stat_slope(:,1),stat_eng(:,1),'+');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,2);
plot(stat_slope(:,2),stat_eng(:,2),'o');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,3);
plot(stat_slope(:,3),stat_eng(:,3),'+');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,4);
plot(stat_slope(:,4),stat_eng(:,4),'+');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,5);
plot(stat_slope(:,5),stat_eng(:,5),'+');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,6);
plot(stat_slope(:,6),stat_eng(:,6),'+');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,7);
plot(stat_slope(:,7),stat_eng(:,7),'+');xlim([-0.1,0.1]);ylim([0,0.05]);
subplot(4,2,8);
plot(stat_slope(:,8),stat_eng(:,8),'+');xlim([-0.1,0.1]);ylim([0,0.05]);

