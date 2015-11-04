
%
todo = yesterday.StockArrays.(fn{6});
[b1,a1] = butter(1,0.0025,'high');
[b2,a2] = butter(1,0.01,'low');

% y = filter(b,a,x);
%   a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
%                         - a(2)*y(n-1) - ... - a(na+1)*y(n-na)
%%
if(todo.items(1,3)~=0)
    todo_pri = todo.items(:,3);
    todo_t = todo.timearray;
    am_pri = todo_pri(todo_t<10000);
    am_t = todo_t(todo_t<10000);


    int_t = min(am_t):max(am_t);
    int_pri = interp1(am_t,am_pri,int_t);
    detrend_pri = detrend(int_pri);
    detrend_pri = filter(b1,a1,detrend(int_pri));
    [~,zf1] = filter(b1,a1,int_pri);
    [~,zf2] = filter(b2,a2,int_pri);
    fft_p = abs(fft(detrend_pri));
    fft_t = (1:length(fft_p))/length(fft_p);
end
figure(1);
subplot(2,1,1);
hold on
plot(int_t,int_pri,'b');
plot(int_t,filter(b2,a2,int_pri,zf2),'g');
plot(int_t,filter(b2,a2,int_pri,zf2)+filter(b1,a1,int_pri,zf1),'r');
ylim([0.9,1.1]*todo.items(1,3));
subplot(2,1,2);
plot(int_t,filter(b1,a1,int_pri,zf1));
ylim([-0.5,0.5]);
%{
hold on
plot(fft_t,fft_p);
xlim([0,0.05]);
set(gca,'xtick',[1/300,1/180,1/120,1/60],'xticklabel',{'5','3','2','1'})
%}