
str = cd;
disp(str);
%cd('d:\Zhly\Documents\MATLAB\stock\fetch_raw_data')
[a1] = GenerateUrls();
save('a.mat','a1');
disp('started by schduled tasks');
disp('developing new version of fetcher');

dailyTask

disp('finished');

%shutdown = questdlg('shut down?');
%if strcmp(shutdown ,'Yes')
%    system('shutdown -h');
%end