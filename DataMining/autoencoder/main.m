%load('D:\Document Files\Stock\zip\2015_07_29.mat');
%yesyesterday = load('D:\Document Files\Stock\zip\2015_07_27.mat');
%%
fn = fieldnames(StockArrays);
    sum_p = zeros(1,2616);
for i = 1:length(fn)
    %plot_lines(StockArrays,fn{i});
    todo = today.StockArrays.(fn{i});
    dsp_test;
    sum_p = sum_p + fft_p;
end

figure(3);
hold on
plot(fft_t,sum_p);
xlim([0,0.05]);
set(gca,'xtick',[1/300,1/180,1/120,1/60],'xticklabel',{'5','3','2','1'})