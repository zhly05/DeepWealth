function [ NN ] = CreateNN( NN_size )
%CREATENN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    NN.size = NN_size;
    NN.layersN = length(NN_size);
    
    NN.iterN = 1000;
    
    NN.alpha = 0.005;
    NN.beta = 0;0.001;
    NN.lamda = 0;0.001;
    NN.rho = 0.05;
    
    
    
end

