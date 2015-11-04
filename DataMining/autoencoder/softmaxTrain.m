function [ theta ] = softmaxTrain( trainData , labelM , theta_in)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


%% parameters
[inN, fragN] = size(trainData);
[outK, ~] = size(labelM);
%nodeN = 25;
iterN = 2000;

alpha = 0.001;
lamda = 0.1;

figure(2);
plot(trainData);

%% Initlization

if nargin < 3
    theta = (rand(outK,inN)-0.5)*0.1;
else
    theta = theta_in;   
end


for i = 1:iterN
    thetaX = theta * trainData;
    vecP = exp(thetaX - repmat(mean(thetaX),outK,1));
    sumP = repmat(sum(vecP),outK,1);
    theta = theta + alpha*(((labelM - vecP./sumP) * trainData')/fragN - lamda*theta);
    
    if(mod(i,20)==1)
        %plot(thetaX);
        plot(vecP./sumP);
        drawnow;
    end
end

end

