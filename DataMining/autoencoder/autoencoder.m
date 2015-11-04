%% this script is used for test autoencoder in processing stock signal
%http://blog.sina.com.cn/s/blog_593af2a70101endk.html


%% generate data fragment
fragN = 500;
timeInt = 60;
StockFrag = zeros(timeInt,fragN);

%load('zip/2015_07_28.mat')
fnames = fieldnames(StockArrays);
stockN = length(fnames);
randIdx = randi(stockN,1,fragN);
i = 1;
while(i <= fragN)
    temparray = StockArrays.(fnames{randIdx(i)});
    randT = temparray.timearray(randi(length(temparray.timearray)))+randi(10);
    while(randT>7140&&randT<12000)
        randT = temparray.timearray(randi(length(temparray.timearray)))+randi(10);
    end
    while(randT>19740&&randT<21000)
        randT = temparray.timearray(randi(length(temparray.timearray)))+randi(10);
    end
    StockFrag(:,i) = interp1(temparray.timearray,temparray.items(:,3),randT:randT+timeInt-1);
    if(StockFrag(1,i)==0)
        randIdx(i) = randi(stockN);
        i = i - 1;
    else
        StockFrag(:,i) = (StockFrag(:,i)/StockFrag(1,i)-1)*10;
    end
    i = i + 1;
end
figure(2);
plot(StockFrag);

%%
[ pre_weight, post_weight ] = autoencoder_core( StockFrag, 25 );


%%
