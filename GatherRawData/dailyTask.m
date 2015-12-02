% This script is the entrance of the daily task.
% Revised and formatted by Lingyu, 2015/11/04.


%% Setup Environment & Const

if ~exist('StockInfo','var')
    StockInfo = load('Stockcode.mat');
    
    % time points to start
    Time_Setting.time0925 = datenum(datevec(floor(now)) +   [0 0 0 09 25 00]);
    Time_Setting.time1135 = datenum(datevec(floor(now)) +   [0 0 0 11 35 00]);
    Time_Setting.time1255 = datenum(datevec(floor(now)) +   [0 0 0 12 55 00]);
    Time_Setting.time1505 = datenum(datevec(floor(now)) +   [0 0 0 15 05 00]);
    Time_Setting.alarm0926vec = datevec(floor(now)) +       [0 0 0 09 26 00];
    Time_Setting.alarm1256vec = datevec(floor(now)) +       [0 0 0 12 56 00];
    Time_Setting.interval = 20; %(sec). 20 for testing, 2.4 for real case.
end

%% Load URLs from URLs.txt
% the urls are stored in several lines in file.
% loaded as urls{i}, each i for each line.
if ~exist('url_s','var')
    %clc; clear; close;
    fid = fopen('URLs.txt','r');
    url_N = 0;
    while(~feof(fid))
        url_N = url_N + 1;
        url_s{url_N} = fgetl(fid);    
    end
    fclose(fid);
    clear fid;
    const_comma = cell(url_N,1);
    for i = 1:url_N        
        const_comma{i} = repmat({','},StockInfo.SperPage(i),1);
    end
end

%% Initialize StockArray 
if ~exist('timeN','var')
    frame_KeyTime = zeros(3600,url_N)-2000;
    StockInfo.stockN = sum(StockInfo.SperPage);
    %StockArrays = repmat(,stockN,1);
    for i = 1:StockInfo.stockN
        temp_code = StockInfo.Stockcode(i,:);
        StockArrays.(temp_code) = struct('code',temp_code,'name',StockInfo.Stockname{i},'date',datestr(now,'yyyy-mm-dd'),'timearray',zeros(3600,1)-2000,'items',zeros(3600,29));
    end
    url_iter = ones(1,url_N);
end

%% Main process. Fetch raw data.
time_LastGoTime = 1;
while time_LastGoTime >= 0
    time_LastGoTime = ScheduleBrake( Time_Setting);
    if(time_LastGoTime == 0)
        continue;
    end
    sprintf('Go.')
    % Loop
    for url_i = 1:url_N
        [raw_str, raw_ticktime] = FetchRawString(url_s{url_i});
        % check if this rawstr is unique by keytime.
        if ~any(frame_KeyTime(:,url_i) == raw_ticktime)
            [raw_frame, vaild_flag]= RawStr2Frame(raw_str, const_comma{url_i});
            if(vaild_flag)
                frame_KeyTime(url_iter(url_i),url_i) = raw_ticktime;
            else
                toc(time_LastGoTime)
                continue;
            end
            
            i_raw = 1;
            for i_total = StockInfo.startIdx(url_i):StockInfo.endIdx(url_i)
                temp_code = StockInfo.Stockcode(i_total,:);
                StockArrays.(temp_code).timearray(url_iter(url_i)) = raw_ticktime;
                StockArrays.(temp_code).items(url_iter(url_i),:) = raw_frame.items(i_raw,:);
                i_raw = i_raw + 1;
            end
            
            disp(raw_ticktime)
            url_iter(url_i) = url_iter(url_i) + 1;
            toc(time_LastGoTime)
        end    
    end
end


%% Update low frequency parameters (daily)
StockSFA = FetchShareFlow(StockInfo);
for i = 1:length(StockInfo.Stockcode)
    StockArrays.(StockInfo.Stockcode(i,:)).shareflow = StockSFA(i);
end

%% Postprocess
% unfinished
for i = 1:StockInfo.stockN
    % truncate Stock
    temp_code = StockInfo.Stockcode(i,:);
    idx = StockArrays.(temp_code).timearray > -60;
    StockArrays.(temp_code).timearray = StockArrays.(temp_code).timearray(idx);
    StockArrays.(temp_code).items = StockArrays.(temp_code).items(idx,:);    
end
    
%% Save StockArray data 
Name_StockArray = [Path_LocalData, datestr(floor(now),'yyyy_mm_dd'),'.mat'];
if ~exist(Name_StockArray,'file')
    save(Name_StockArray,'StockArrays');
    clear Stock*;
else
    % what if there is a file
end
disp('file exists');
%% Shut down
