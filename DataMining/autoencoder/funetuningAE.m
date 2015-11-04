function [ output_args ] = funetuningAE( L1,L2,theta, trainData, labelM )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
[timeInt, fragN] = size(trainData);
fragN = 651;
alpha = 0.05;

w2 = L2{1}(:,1:end-1);
b2 = L2{1}(:,end);


Layer2data = cell(20,1);
for i = 1:20    
    z2{i} = L1{i,1} * [trainData{i};ones(1,fragN)];
    a2{i} = sigmoid(z2{i});
end
a2 = cat(1,a2{:});


z3 =L2{1} * [a2;ones(1,fragN)];
a3 = sigmoid(z3);

thetaX = theta * [a3;ones(1,fragN)];

vecP = exp(thetaX - repmat(mean(thetaX),7,1));
sumP = repmat(sum(vecP),7,1);

    delta3 = -theta'*(labelM - vecP./sumP).*deri_sig_tanh(a3);
    delta2 = (w2'*delta3).*deri_sig_tanh(a2);
    %delta1 = (w1'*delta2).*deri_sig_tanh(a1);


    deltaW2 = delta3*a2';
    deltab2 = sum(delta3,2);
    deltaW1 = delta2*a1';
    deltab1 = sum(delta2,2);

    w2 = w2 - alpha * ((deltaW2/fragN) + lamda * w2);
    b2 = b2 - alpha * ((deltab2/fragN));
    
    for i = 1:20
        
        Layer2data{i} = L1{i,1} * [trainData{i};ones(1,fragN)];
    end
    w1 = w1 - alpha * ((deltaW1/fragN) + lamda * w1);
    b1 = b1 - alpha * ((deltab1/fragN));
end


%% Unlinear function (-1,1)
function y = sigmoid(x)
    %y = 1./(1+exp(-x));
    y = tanh(2*x);
end
function y = deri_sig_tanh(tanhx)
    %y = tanhx .* (1 - tanhx);
    y = 2 - 2*tanhx.^2;
end
