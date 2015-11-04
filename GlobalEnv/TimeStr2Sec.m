function [ sec_num ] = TimeStr2Sec( time_str )
%TIMESTR2SEC Summary of this function goes here
%   Detailed explanation goes here


    sec_num = str2double(time_str(7:8)) + str2double(time_str(4:5))*60 + str2double(time_str(1:2))*3600 - 34200;

end

