function [ NN ] = CreateNN( NN_size , NN_type)
% Create a standard Neuron Network with several layers.
% size(1) indicts the number of input. size(end) is for the output layer.
% There are length(size)-2 hidden layers.
% NN.HiddenLayers are struct array with NNsize-1 layers in it.
% Input --> HiddenLayers(1) --> ... --> HiddenLayers(layersN-1) --> Output
%
% Type
%       f: Fully connected;
%       c: Convolutional;
%       s: Subsample;

    NN.size = NN_size;
    NN.layersN = length(NN_size) - 1;
    if nargin == 1
        NN_type = cellstr(repmat('f', NN.layersN, 1))';
    elseif nargin == 2
        assert(length(NN_type) == NN.layersN, 'need length(size)-1 letters to format the type of NN');
        if ischar(NN_type)
            NN_type = cellstr(reshape(NN_type, NN.layersN, 1))';
        elseif iscell(NN_type)
            NN_type = reshape(NN_type, NN.layersN, 1)';
        else
            error('Create NN Failed');
        end
    end
    NN.HiddenLayers = struct('type',lower(NN_type));
    
    for i = 1:NN.layersN - 1
        NN.HiddenLayers(i).size = [NN_size(i+1), NN_size(i)];
        % layer(i) to layer(i+1) 
        NN.HiddenLayers(i).w1 = rand(NN_size(i+1),NN_size(i)) * 0.1;
        NN.HiddenLayers(i).b1 = rand(NN_size(i+1),1) * 0.1;
        % layer(i+1) to layer(i) 
        NN.HiddenLayers(i).w2 = rand(NN_size(i),NN_size(i+1)) * 0.1;
        NN.HiddenLayers(i).b2 = rand(NN_size(i),1) * 0.1;
        
        NN.HiddenLayers(i).iterN = 1000;
        NN.HiddenLayers(i).alpha = 0.005;
        NN.HiddenLayers(i).beta = 0;0.001;
        NN.HiddenLayers(i).lamda = 0;0.001;
        NN.HiddenLayers(i).rho = 0.05;
    end
    
end

