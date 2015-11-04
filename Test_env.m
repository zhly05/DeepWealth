clear; close; clc;
%% const defination
Path_DeepWealth = 'd:\Zhly\Documents\GitHub\DeepWealth\';
Path_Root = Path_DeepWealth;

%local data path, YYYY_MM_DD.mat
Path_LocalData = 'G:\StockData\local\';
%small dataset for testing and developing
Path_DevData = [Path_DeepWealth 'DataForTest\'];
%Remote data path, data was gathered by the other desktop and shared via HD
Path_RemoteData = 'Z:\Stock\Data\local\';


%Matlab script functional blocks
Path_GatherDataBlk = [Path_Root 'GatherRawData\'];
Path_DataMiningBlk = [Path_Root 'DataMining\'];
Path_GUIBlk = [Path_Root 'GUI\'];
Path_GlobalEnv = [Path_Root 'GlobalEnv\'];

%%
%StockArray = load([RawDataPath '2015_07_29.mat']);


%% add path
addpath(Path_GlobalEnv);