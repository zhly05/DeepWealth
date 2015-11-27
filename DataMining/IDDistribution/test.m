%�ҵ���Сֵ��
%clear;
close all
%%
y0 = g_2;
Wn = 17/length(y0)*2;
[Bb,Ba] = butter(3,Wn,'high'); % ����MATLAB butter������������˲���  
[~,z] = filter(Bb,Ba,y0(end:-1:1),[0,0,0]); % ���и�ͨ�˲�  
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