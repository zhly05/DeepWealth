%% generate data fragment
pick_ratio = 0.7;
timeInt = 60;


sigmoid =@(x) tanh(2*x);

load('zip/2015_10_21.mat')
fnames = fieldnames(StockArrays);
stockN = length(fnames);
fragN = floor(pick_ratio * stockN);
randIdx = randperm(stockN,fragN);
%randIdx = randi(stockN,1,fragN);
trainData = cell(20,1);
emptyIdx = false * ones(1,fragN);
for i = 1:fragN    
    if(StockArrays.(fnames{randIdx(i)}).items(1,3)==0)
        emptyIdx(i) = true;
    end
end
randIdx(emptyIdx == 1) = [];
fragN = length(randIdx);



StockFrag = zeros(timeInt-1,fragN);
for j = 1:90
    for i = 1:fragN    
        temparray = StockArrays.(fnames{randIdx(i)});
        Tstart = (j-1+10)*60+60+ randi(7)-4 + 12000;
        temp = interp1(temparray.timearray,temparray.items(:,3),Tstart:Tstart+timeInt-1);
        if(temp==0)
            randIdx(i) = randi(stockN);
        else
            StockFrag(:,i) = (temp(2:end)/temp(1)-1)*8;
        end
    end
    trainData{j} = StockFrag;    
end
figure(2);
plot(StockFrag);
%%
%Layer1 = cell(20,2);
%load('weight25.mat')
epsilon = 1e-5;
for i = 1:90
    [coeff, score, latent,~,explained] = pca(trainData{i}');
    
    trainData{i} = diag(1./sqrt(latent) + epsilon) * coeff' * trainData{i}/20;
    post_weight = coeff(:,1:25)*0.7; 
    pre_weight = post_weight';
    [ temppre_weight, temppost_weight ] = autoencoder_core( trainData{i}, 25 );%, pre_weight, post_weight);
    Layer1{i,1} = temppre_weight;
    Layer1{i,2} = temppost_weight;   
    sprintf('layer%d finished',i)
end
%%
figure(3);
hold on;
for i = 1:90
    plot(Layer1{i, 1}(9,:))
end
hold off;
%%
Layer2data = cell(90,1);
for i = 1:90
    Layer2data{i} = sigmoid(Layer1{i,1} * [trainData{i};ones(1,fragN)]);
end
for i = 1:9
    trainData2{i} = cat(1,Layer2data{(i-1)*10+1:i*10});
end
%%
sprintf('layer2 start')%
temppre_weight = Layer2{1};
%temppre_weight(randperm(100,10),:) = (rand(10,2250+1)-0.5)*0.1;
[ temppre_weight, temppost_weight ] = autoencoder_core( traindata2, 100, temppre_weight, Layer2{2});
Layer2{1} = temppre_weight;
Layer2{2} = temppost_weight;   

%%
i = 1;
[ temppre_weight, temppost_weight ] = autoencoder_core( trainData2{i}, 50);%, temppre_weight, Layer2{i,2});
    
%%

    [coeff, score, latent, tsquared, explained] = pca(trainData2{1}');
    post_weight = coeff(:,1:128)*0.7; 
    pre_weight = post_weight';
for i = 1:9
    %temppre_weight = Layer2{i,1};
    [ temppre_weight, temppost_weight ] = autoencoder_core( trainData2{i}, 128 , pre_weight, post_weight);
    Layer2{i,1} = temppre_weight;
    Layer2{i,2} = temppost_weight;   
    sprintf('layer%d finished',i)
end
sprintf('layer2 finished')
%%

for i = 1:9
    Layer3data{i} = sigmoid(Layer2{i,1} * [trainData2{i};ones(1,fragN)]);
end
trainData3{1} = cat(1,Layer3data{:});

%Layer3data = sigmoid(Layer2{1} * [traindata2;ones(1,fragN)]);
%traindata3 = Layer3data;
%%
trainLabelM = labelM(:,randIdx);
[ theta ] = softmaxTrain( [trainData3{1}/2+0.5;ones(1,fragN)] , trainLabelM );
sprintf('layer3 finished')


