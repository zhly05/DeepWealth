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
    
    NN.iterN = 1000;
    NN.alpha = 0.005;
    NN.beta = 0;0.001;
    NN.lamda = 0;0.001;
    NN.rho = 0.05;
end

