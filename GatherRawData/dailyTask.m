% This script is the entrance of the daily task.
% Revised and formatted by Lingyu, 2015/11/04.

%% Load URLs from URLs.txt
% the urls are stored in several lines in file.
% loaded as urls{i}, each i for each line.
if ~exist('urls','var')
    clc; clear; close;
    fid = fopen('URLs.txt','r');
    i = 1;
    while(~feof(fid))
        urls{i} = fgetl(fid);    
        i = i + 1;
    end
    fclose(fid);
    clear fid;
    urlN = i - 1;
    misc_comma = cell(urlN,1);
    EnvParameters = load('Stockcode.mat');
    for i = 1:urlN        
        misc_comma{i} = repmat({','},EnvParameters.SperPage(i),1);
    end
    misc_hash =@(timestr) str2double(timestr(7:8)) + str2double(timestr(4:5))*60 + str2double(timestr(1:2))*3600 - 34200;
    misc_time1 = datenum(datevec(floor(now))+[0 0 0 09 25 00]);
    misc_time2 = datenum(datevec(floor(now))+[0 0 0 11 35 00]);
    misc_time3 = datenum(datevec(floor(now))+[0 0 0 12 55 00]);
    misc_time4 = datenum(datevec(floor(now))+[0 0 0 15 05 00]);
end

% unfinished.