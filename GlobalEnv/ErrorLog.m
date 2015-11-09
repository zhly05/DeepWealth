function [ output_args ] = ErrorLog( excepOstr, errorFileName )
%ERRORLOG Summary of this function goes here
%   Detailed explanation goes here

if nargin > 1
else
    stack = dbstack();
    errorFileName = stack(end).name;
end


Path_Log = evalin('base','Path_Log');
name_errorlog = [Path_Log errorFileName '.txt'];
fid = fopen(name_errorlog,'a');
fprintf(fid,'----%s----\n',datestr(now));
if ischar(excepOstr)
    to_write = sprintf('%s',excepOstr);
else
    stackStr = stack2str(excepOstr.stack);
    to_write = sprintf('%s\n%s\n%s\n%s',excepOstr.identifier, excepOstr.message, stackStr);
end
fprintf(fid,'%s',to_write);
fclose(fid);
end

function str = stack2str(stack)
    str = '';
    for i = 1:length(stack)
        thisline = sprintf('stack(%d)--Line: %d,  Func: %s,  in File:%s\n',i,stack(i).line, stack(i).name, stack(i).file);
        str = [str thisline];
    end
end