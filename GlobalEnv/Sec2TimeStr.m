function [ time_str, h, m, s] = Sec2TimeStr(sec_num)
% translate second num to 'hh:mm:ss'
% and also give h,m,s num
    temp_num = sec_num + 34200;
    s = mod(temp_num,60);
    m = mod(floor(temp_num/60),60);
    h = floor(temp_num/3600);
    time_str = sprintf('%02d:%02d:%02d',h,m,s);
end

