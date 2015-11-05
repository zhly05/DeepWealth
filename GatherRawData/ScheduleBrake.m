function [ ret_GoTime ] = ScheduleBrake( time_Setting)
%ScheduleBrake Summary of this function goes here
% [ is_a_go ] = ScheduleBrake( time_Setting)
% is_a_go: -1 break;  0 continue;  >0 go
%   time_Setting:
%       .time0925
%       .time1135
%       .time1255
%       .time1505
%       .alarm0926vec
%       .alarm1256vec
%       .interval
    persistent last_gotime;
    if isempty(last_gotime)
        last_gotime = tic;
    end
    
    time_now = now;
    % schedule: 15:05 -- 23:29  break loop --> next step
    if time_now > time_Setting.time1505
        ret_GoTime = -1;
        return;
    end
    
    ret_GoTime = 0;
    if time_now < time_Setting.time0925
        % schedule: 00:00 -- 09:25
        disp(['Sleeping Check: ' datestr(clock)]);
        pause(min(etime(time_Setting.alarm0926vec, clock), 600));
        return;
    elseif time_now > time_Setting.time1135 && time_now < time_Setting.time1255
        % schedule: 11:35 -- 12:55
        disp(['Sleeping Check: ' datestr(clock)]);
        pause(min(etime(time_Setting.alarm1256vec, clock), 600));
        return;
    else        
        % schedule: 09:25 -- 11:35 || 12:55 -- 15:05
        % Interval Control
        while toc(last_gotime) < time_Setting.interval
            pause(0.2)
        end
        last_gotime = tic;
        ret_GoTime = last_gotime;
    end
    
end

