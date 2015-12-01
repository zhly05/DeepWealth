
run ../Test_env.m;

disp('started by schduled tasks');
disp('developing new version of fetcher');

[a1] = GenerateUrls();

dailyTask

disp('finished');

%shutdown = questdlg('shut down?');
%if strcmp(shutdown ,'Yes')
%    system('shutdown -h');
%end