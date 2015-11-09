function [ raw_str, tick_time ] = FetchRawString( url)
%FETCHRAWSTRING Summary of this function goes here
%   Detailed explanation goes here
not_gotdata = 1;
while not_gotdata
    try
        raw_str = urlread(url);
        not_gotdata = 0;
    catch e
        pause(1);
        not_gotdata = 1;
        ErrorLog(e);
    end
end
n = regexp(raw_str(1:300),',\d*:\d*:\d*,');
timestr = raw_str(n+1:n+8);
tick_time = TimeStr2Sec(timestr);
%str2double(timestr(7:8)) + str2double(timestr(4:5))*60 + str2double(timestr(1:2))*3600 - 34200;

end

