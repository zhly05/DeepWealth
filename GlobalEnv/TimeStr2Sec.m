function [ sec_num ] = TimeStr2Sec( time_str )
% map 'hh:mm:ss' to elapsed second counts from 9:30 am
    sec_num = str2double(time_str(7:8)) + str2double(time_str(4:5))*60 + str2double(time_str(1:2))*3600 - 34200;
end

