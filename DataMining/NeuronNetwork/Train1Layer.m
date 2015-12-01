function [ output_args ] = Train1Layer( NN_Layeri, train_data )
% This function is using an autoencoder to train a single hidden layer.
% InputLayer --> NN_Layeri --> OutputLayer

%the length of a single data fragment
%and the number of the fragments in this training data set.
[input_len, input_N] = size(train_data);
assert(input_len == size(NN_Layer.weight,2),'size dismatch between dataset and weight matrix');



%nodeN = 25;
iterN = 150000;
stepK = 4;
prctileP = 0;

alpha = 0.03;
beta = 0;0.001;
lamda = 0;0.001;
rho = 0; 0.05;

figure(2);
plot(trainData);%(1:300,1:20));

%% Initlization
newN = min(0,input_N);

if nargin < 3
    pre_weight = (rand(nodeN,timeInt+1)-0.5)*0.1;
    post_weight = (rand(timeInt,nodeN+1)-0.5)*0.1;
    %pre_weight(1:newN,1:end-1) = trainData(:,randperm(fragN,newN))';
else
    pre_weight = pre_W_in;   
    post_weight = post_W_in;
end
w1 = pre_weight(:,1:timeInt);
b1 = pre_weight(:,end);
w2 = post_weight(:,1:nodeN);
b2 = post_weight(:,end);

z1 = trainData;
a1 = z1;


for iter = 1:iterN 
%% Forward Propagation
% 需要注意的是，除了第一层外所有的神经元都有sigmoid的输出，之前错了。
% http://ufldl.stanford.edu/wiki/index.php/Neural_Networks
    z2 = w1 * a1 + repmat(b1,1,input_N);
    a2 = sigmoid(z2);

    z3 = w2 * a2 + repmat(b2,1,input_N);
    a3 = sigmoid(z3);
    err = sum((a3(:)-a1(:)).^2);


    %% Backpropagation

    delta3 = -(z1 - a3).*deri_sig_tanh(a3);
    rhoi = sum((a2+1)/2)/input_N;
    delta2 = (w2'*delta3 + repmat(beta*(-(1+rho)./(1+rhoi)+(1-rho)./(1-rhoi)),nodeN,1)).*deri_sig_tanh(a2);
    %delta1 = (w1'*delta2).*deri_sig_tanh(a1);


    deltaW2 = delta3*a2';
    deltab2 = sum(delta3,2);
    deltaW1 = delta2*a1';
    deltab1 = sum(delta2,2);

    w2 = w2 - alpha * ((deltaW2/input_N) + lamda * w2);
    w1 = w1 - alpha * ((deltaW1/input_N) + lamda * w1);
    b2 = b2 - alpha * ((deltab2/input_N) + lamda * b2);
    b1 = b1 - alpha * ((deltab1/input_N) + lamda * b1);

    pre_weight = [w1,b1];
    post_weight = [w2,b2];
    if(mod(iter,1000)==0)
        
        figure(1);
        subplot(1,3,1)
            plot(pre_weight','DisplayName','currOutputVals');
        subplot(1,3,2)
            plot(a2(1:nodeN,:),'DisplayName','currOutputVals');
        subplot(1,3,3)
            plot(a3,'DisplayName','currOutputVals');
        drawnow;
        
    end
    if(mod(iter,1000)==0)
        disp(iter);
        disp(err);
    end
end


end

