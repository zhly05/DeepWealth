function [ NN ] = CreateNN( NN_size )
%CREATENN 此处显示有关此函数的摘要
%   此处显示详细说明
    NN.size = NN_size;
    NN.layersN = length(NN_size);
    
    NN.iterN = 1000;
    
    NN.alpha = 0.005;
    NN.beta = 0;0.001;
    NN.lamda = 0;0.001;
    NN.rho = 0.05;
    
    
    
end

