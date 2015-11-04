%%
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
%%
if ~exist('timeN','var')
    Timearray = zeros(3600,urlN)-2000;
    Frames(urlN) = struct('time','','date','','local_time','','items','');
    stockN = sum(EnvParameters.SperPage);
    %StockArrays = repmat(,stockN,1);
    for i = 1:stockN
        temp_code = EnvParameters.Stockcode(i,:);
        StockArrays.(temp_code) = struct('code',temp_code,'name',EnvParameters.Stockname{i},'date',datestr(now,'yyyy-mm-dd'),'timearray',zeros(3600,1)-2000,'items',zeros(3600,29));
    end
    timeN = [1,1];
end
%%
Tstart = tic;
while 1
    Tnow = now;
    if Tnow > misc_time4
        break;
    end
    if Tnow < misc_time1
        disp(clock);
        pause(min(etime(datevec(floor(now))+[0 0 0 09 26 00],clock),600));
    end
    if Tnow > misc_time2 && Tnow < misc_time3
        disp(clock);
        pause(min(etime(datevec(floor(now))+[0 0 0 12 56 00],clock),600));
    end
    while toc(Tstart)<2.4
        pause(0.2)
    end
    Tstart = tic;
    for i = 1:urlN
        [raw_str, ticktime] = FetchRawString(urls{i});
        if ~any(Timearray(:,i) == ticktime)  
            [temp_frame, vaild_flag]= FetchSingleFrame(raw_str, misc_comma{i});
            if(vaild_flag)
                Timearray(timeN(i),i) = ticktime;
                Frames(i) = temp_frame;
            else
                toc(Tstart)
                continue;
            end
            
            jj = 1;
            for j = EnvParameters.startIdx(i):EnvParameters.endIdx(i)
                temp_code = EnvParameters.Stockcode(j,:);
                StockArrays.(temp_code).timearray(timeN(i)) = ticktime;
                StockArrays.(temp_code).items(timeN(i),:) = Frames(i).items(jj,:);
                jj = jj + 1;
            end
            
            disp(ticktime)
            timeN(i) = timeN(i) + 1;
            toc(Tstart)
        end    
    end
end
post_filename = ['g:/StockData/local/' datestr(floor(now),'yyyy_mm_dd') '.mat'];
if ~exist(post_filename,'file')
    tic;
    post_fnames = fieldnames(StockArrays);
    for i = 1:length(post_fnames)
        idx = StockArrays.(post_fnames{i}).timearray > 0;
        StockArrays.(post_fnames{i}).timearray = StockArrays.(post_fnames{i}).timearray(idx);
        StockArrays.(post_fnames{i}).items = StockArrays.(post_fnames{i}).items(idx,:);    
    end
    toc;
    save(post_filename,'StockArrays');
    clear Stock*;
end
disp('file exists');

%%