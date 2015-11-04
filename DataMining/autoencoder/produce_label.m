
%today = load('zip/2015_07_28.mat');
%yesterday = load('zip/2015_07_27.mat');
fnames = fieldnames(StockArrays);
stockN = length(fnames);
ratio = zeros(stockN,1) * NaN;
label = zeros(stockN,1) * NaN;
for i = 1:stockN
    temparray = StockArrays.(fnames{i});
    try
        ratio(i) = interp1(temparray.timearray,temparray.items(:,3),60*10)/temparray.items(2,1);
    catch
    end
end
label(ratio<1.04) = 0;
label(ratio<0.99) = -1;
label(ratio<0.98) = -2;
label(ratio<0.96) = -3;
label(ratio>1.01) = 1;
label(ratio>1.02) = 2;
label(ratio>1.04) = 3;
labelM(1,label==-3) = 1;
labelM(2,label==-2) = 1;
labelM(3,label==-1) = 1;
labelM(4,label==0) = 1;
labelM(5,label==1) = 1;
labelM(6,label==2) = 1;
labelM(7,label==3) = 1;