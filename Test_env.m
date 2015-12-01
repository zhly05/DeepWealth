%% Env Setup Todo List
% you should update all the paths here.



clear; close; 
%% const defination
Path_DeepWealth = 'd:\Zhly\Documents\GitHub\DeepWealth\';
Path_Root = Path_DeepWealth;

%local data path, YYYY_MM_DD.mat
Path_LocalData = 'G:\StockData\local\';
%Remote data path, data was gathered by the other desktop and shared via HD
Path_RemoteData = 'Z:\Stock\Data\local\';


%small dataset for testing and developing
Path_DevData = [Path_DeepWealth 'DataForTest\'];

%Matlab script functional blocks
Path_GatherDataBlk = [Path_Root 'GatherRawData\'];
Path_DataMiningBlk = [Path_Root 'DataMining\'];
Path_GUIBlk = [Path_Root 'GUI\'];
Path_GlobalEnv = [Path_Root 'GlobalEnv\'];
Path_Log = [Path_Root 'Log\'];
Path_AutoExecute = [Path_Root 'AutoExecute\'];

%% run autohotkey scripts
addpath(Path_GlobalEnv);
winopen([Path_AutoExecute 'AHKscripts\AutoExecute.ahk']);
%%
%StockArray = load([RawDataPath '2015_07_29.mat']);

%% add path
addpath(Path_GlobalEnv);
% pcode GlobalEnv to speed up

return;
f = dir([Path_GlobalEnv '*.m']);
for i = 1:length(f)
    pcode(f(i).name(1:end-2),'-inplace')
end
clear f i;