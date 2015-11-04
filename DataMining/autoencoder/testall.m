testIdx = setdiff(1:stockN,randIdx);
testN = length(testIdx);
emptyIdx = false * ones(1,testN);
for i = 1:testIdx    
    if(StockArrays.(fnames{testIdx(i)}).items(1,3)==0)
        emptyIdx(i) = true;
    end
end
testIdx(emptyIdx == 1) = [];
testN = length(testIdx);

StockFrag = zeros(timeInt,testN);
for j = 1:90
    for i = 1:testN    
        temparray = StockArrays.(fnames{testIdx(i)});
        Tstart = (j-1)*60+60+ randi(7)-4 + 12000;
        StockFrag(:,i) = interp1(temparray.timearray,temparray.items(:,3),Tstart:Tstart+timeInt-1);
        if(StockFrag(1,i)==0)
            testIdx(i) = randi(stockN);
        else
            StockFrag(:,i) = (StockFrag(:,i)/StockFrag(1,i)-1)*8;
        end
    end
    testData{j} = StockFrag;    
end
figure(2);
plot(StockFrag);

Layer2data = cell(20,1);
for i = 1:20
    Layer2data{i} = Layer1{i,1} * [testData{i};ones(1,testN)];
end
testdata2 = cat(1,Layer2data{:});
Layer3data = Layer2{1} * [testdata2;ones(1,testN)];
testdata3 = Layer3data;
plot(theta * testdata3);
