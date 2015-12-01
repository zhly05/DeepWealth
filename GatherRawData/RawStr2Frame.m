function [ frame , valid_flag ] = RawStr2Frame( raw_str, comma)
%FETCH_FRAME Summary of this function goes here
%   Detailed explanation goes here
try
    temp_cell = strsplit(raw_str,'"');
    temp_ccell = cellfun(@strsplit,temp_cell(2:2:end)',comma,'UniformOutput',false);
    temp_cell = cat(1,temp_ccell{:});
    frame = struct('time','','date','','local_time','','items','');
    frame.date = temp_cell{1,31};
    frame.time = temp_cell{1,32};
    frame.local_time = datestr(now,'yyyy_mm_dd_HH_MM_SS');
    frame.items = str2double(temp_cell(:,2:30));
    valid_flag = true;
catch e 
    frame = struct('time','','date','','local_time','','items','');
    valid_flag = false;
    ErrorLog(e);
    disp(datestr(now,'yyyy_mm_dd_HH_MM_SS'));
end
end