% This script is the entrance of the daily task.
% Revised and formatted by Lingyu, 2015/11/04.

%% Load URLs from URLs.txt
% the urls are stored in several lines in file.
% loaded as urls{i}, each i for each line.
if ~exist('urls','var')
    clc; clear; close;
    fid = fopen('URLs.txt','r');
    urlN = 0;
    while(~feof(fid))
        urlN = urlN + 1;
        urls{urlN} = fgetl(fid);    
    end
    fclose(fid);
    clear fid;
end

%% Setup Environment & Const
addpath('../GlobalEnv')
if ~exist('EnvParameters','var')
    StockInfo = load('Stockcode.mat');
    const_comma = cell(urlN,1);
    for i = 1:urlN        
        const_comma{i} = repmat({','},StockInfo.SperPage(i),1);
    end
    
    % time points to start
    time_Setting.time0925 = datenum(datevec(floor(now)) +   [0 0 0 09 25 00]);
    time_Setting.time1135 = datenum(datevec(floor(now)) +   [0 0 0 11 35 00]);
    time_Setting.time1255 = datenum(datevec(floor(now)) +   [0 0 0 12 55 00]);
    time_Setting.time1505 = datenum(datevec(floor(now)) +   [0 0 0 15 05 00]);
    time_Setting.alarm0926vec = datevec(floor(now)) +       [0 0 0 09 26 00];
    time_Setting.alarm1256vec = datevec(floor(now)) +       [0 0 0 12 56 00];
    time_Setting.interval = 2.4; %(sec).
end

%% Initialize StockArray 
if ~exist('timeN','var')
    frame_KeyTime = zeros(3600,urlN)-2000;
    Frame(urlN) = struct('time','','date','','local_time','','items',''); % can be deleted
    stockN = sum(StockInfo.SperPage);
    %StockArrays = repmat(,stockN,1);
    for i = 1:stockN
        temp_code = StockInfo.Stockcode(i,:);
        StockArrays.(temp_code) = struct('code',temp_code,'name',StockInfo.Stockname{i},'date',datestr(now,'yyyy-mm-dd'),'timearray',zeros(3600,1)-2000,'items',zeros(3600,29));
    end
    time_iter = [1,1];
end

%% Main process. Fetch raw data.
time_LastGoTime = ScheduleBrake( time_Setting);
while time_LastGoTime >= 0
    if(time_LastGoTime == 0)
        continue;
    end
    
    % Loop
    for url_i = 1:urlN
        [raw_str, raw_ticktime] = FetchRawString(urls{url_i});
        % check if this rawstr is unique by keytime.
        if ~any(frame_KeyTime(:,url_i) == raw_ticktime)
            [raw_frame, vaild_flag]= FetchSingleFrame(raw_str, const_comma{url_i});
            if(vaild_flag)
                frame_KeyTime(time_iter(url_i),url_i) = raw_ticktime;
            else
                toc(time_LastGoTime)
                continue;
            end
            
            j_raw = 1;
            for j_total = StockInfo.startIdx(url_i):StockInfo.endIdx(url_i)
                temp_code = StockInfo.Stockcode(j_total,:);
                StockArrays.(temp_code).timearray(time_iter(url_i)) = raw_ticktime;
                StockArrays.(temp_code).items(time_iter(url_i),:) = raw_frame.items(j_raw,:);
                j_raw = j_raw + 1;
            end
            
            disp(raw_ticktime)
            time_iter(url_i) = time_iter(url_i) + 1;
            toc(time_LastGoTime)
        end    
    end
end


%% Update low frequency parameters (daily)

%% Postprocess
% unfinished
post_fnames = fieldnames(StockArrays);
for i = 1:length(post_fnames)
    % truncate Stock
    idx = StockArrays.(post_fnames{i}).timearray > -60;
    StockArrays.(post_fnames{i}).timearray = StockArrays.(post_fnames{i}).timearray(idx);
    StockArrays.(post_fnames{i}).items = StockArrays.(post_fnames{i}).items(idx,:);    
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
