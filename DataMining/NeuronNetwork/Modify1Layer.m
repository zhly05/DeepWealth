function [ output_layer ] = Modify1Layer( layer_toMod, template )
%MODIFY1LAYER Summary of this function goes here
%   Detailed explanation goes here

    fname = fieldnames(template);
    for i = 1:length(fname)
        switch lower(fname{i})
            case 'w1'
                layer_toMod.w1 = template.w1;
            case 'b1'
                layer_toMod.b1 = template.b1;
            case 'w2'
                layer_toMod.w2 = template.w2;
            case 'b2'
                layer_toMod.b2 = template.b2;
            case 'pre_weight'
                layer_toMod.w1 = template.pre_weight(:,1:end-1);
                layer_toMod.b1 = template.pre_weight(:,end);
            case 'post_weight'
                layer_toMod.w2 = template.post_weight(:,1:end-1);
                layer_toMod.b2 = template.post_weight(:,end);
            case 'itern'
                layer_toMod.itern = template.itern;
            case 'alpha'
                layer_toMod.alpha = template.alpha;
            case 'beta'
                layer_toMod.beta = template.beta;
            case 'lamda'
                layer_toMod.lamda = template.lamda;
            case 'rho'
                layer_toMod.rho = template.rho;
            otherwise
                warning(['field: ' fname{i} 'is unused'])
        end
    end
    output_layer = layer_toMod;
end

