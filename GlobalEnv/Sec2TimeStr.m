function [ time_str, h, m, s] = Sec2TimeStr(sec_num)
%SEC2TIMESTR Summary of this function goes here
%   Detailed explanation goes here
    temp_num = sec_num + 34200;
    s = mod(temp_num,60);
    m = mod(floor(temp_num/60),60);
    h = floor(temp_num/3600);
    time_str = sprintf('%02d:%02d:%02d',h,m,s);
end

