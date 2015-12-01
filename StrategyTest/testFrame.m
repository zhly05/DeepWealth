%load([Path_LocalData '2015_10_29.mat']);
%load([Path_LocalData files(f).name]);
    fNames = fieldnames(StockArrays);
    for i = 1:length(fNames)
        todoCode = fNames{i};        
        WaveLet(StockArrays.(todoCode).items(:,3));
    end  
    tot_Hvec = tot_Hvec * 0.95;
    fprintf('.');