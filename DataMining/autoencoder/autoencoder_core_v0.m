function [ pre_weight, post_weight ] = autoencoder_core( trainData, nodeN )
%AUTOENCODER_CORE 此处显示有关此函数的摘要
%   此处显示详细说明

figure(2);
plot(trainData);
[timeInt, fragN] = size(trainData);
nodeN = 25;
iterN = 400;
stepK = 4;
prctileP = 0;
pre_weight = (rand(nodeN,timeInt+1)-0.5)*0.1;triu(ones(nodeN,timeInt+1),0);%zeros(timeInt+1,nodeN);
normP = sqrt(sum(pre_weight.^2,2));
pre_weight = pre_weight./repmat(normP,1,timeInt+1);
post_weight = (rand(timeInt,nodeN+1)-0.5)*0.1;%zeros(nodeN+1,timeInt);

cal_Diff =@(outM) sum((outM(:)-trainData(:)).^2);
oriInputVals = [trainData;ones(1,fragN)*0.1];
hisDiff = -1;
stepL = 0.01;

for iter = 1:iterN 
    
    
    for iter1 = 1:5 
        oriHiddenVals = [pre_weight * oriInputVals;ones(1,fragN)];
        oriOutputVals = sigmoid(post_weight * oriHiddenVals);
        oriDiff = cal_Diff(oriOutputVals);

        [r,c] = size(post_weight);
        shiftPostDiff = zeros(r,c);
        currHiddenVals = [pre_weight * oriInputVals;ones(1,fragN)];
        for i = 1:r
            for j = 1:c
                post_weight(i,j) = post_weight(i,j) + stepL;
                currOutputVals = sigmoid(post_weight * currHiddenVals);
                shiftPostDiff(i,j) = (oriDiff - cal_Diff(currOutputVals));
                post_weight(i,j) = post_weight(i,j) - stepL;
            end
        end    

        ASPD = abs(shiftPostDiff);
        thrd = prctile(ASPD(:),prctileP);
        idx2 = find(ASPD(:)>thrd);
        post_weight(idx2) = post_weight(idx2) + stepK * shiftPostDiff(idx2) * stepL;
    end

    [r,c] = size(pre_weight);
    shiftPreDiff = zeros(r,c);
    for i = 1:r
        for j = 1:c
            pre_weight(i,j) = pre_weight(i,j) + stepL;
            currHiddenVals = [pre_weight * oriInputVals;ones(1,fragN)];
            currOutputVals = sigmoid(post_weight * currHiddenVals);
            shiftPreDiff(i,j) = (oriDiff - cal_Diff(currOutputVals));
            pre_weight(i,j) = pre_weight(i,j) - stepL;
        end
    end
    
    ASPD = abs(shiftPreDiff);
    thrd = prctile(ASPD(:),prctileP);
    idx1 = find(ASPD(:)>=thrd);
    pre_weight(idx1) = pre_weight(idx1) + 5*stepK * shiftPreDiff(idx1) * stepL;

    normP = sqrt(sum(pre_weight.^2,2));
    pre_weight = pre_weight./repmat(normP,1,timeInt+1);
    
    if(mod(iter,1)==0)
        figure(1);
        subplot(1,3,1)
            plot(pre_weight','DisplayName','currOutputVals');
        subplot(1,3,2)
            plot(oriHiddenVals(1:nodeN,:),'DisplayName','currOutputVals');
        subplot(1,3,3)
            plot(oriOutputVals,'DisplayName','currOutputVals');
        drawnow;
    end
    
    
    if(mod(iter,10)==0)
        if(abs(hisDiff-oriDiff)<1e-4)
            hisDiff
        end
        hisDiff = oriDiff;
    end
    
    disp(oriDiff);
end
disp(oriDiff);
end

function y = sigmoid(x)
    e = exp(3.5*x);
    y = 1 - 1./(1+e);
end
