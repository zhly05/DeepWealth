%找到极小值点
%clear;
close all
%%
y0 = g_2;
Wn = 17/length(y0)*2;
[Bb,Ba] = butter(3,Wn,'high'); % 调用MATLAB butter函数快速设计滤波器  
[~,z] = filter(Bb,Ba,y0(end:-1:1),[0,0,0]); % 进行高通滤波  
[Bf] = filter(Bb,Ba,y0,z); 

d = diff(Bf);
d1 = d(1:end-1);
d2 = d(2:end);
indmin = find(d1.*d2<0)+1;

hold on;
    plot(y0);
    plot(Bf,'r');
    stem(indmin,y0(indmin),'Marker','none');
    plot(zeros(1,length(Bf)),'k');
hold off;