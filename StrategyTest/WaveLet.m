function [ output_args ] = WaveLet( test_data, Rinc, Rdec )
%I4D2 Summary of this function goes here
%   Detailed explanation goes here
Rinc = 0.02;
Rdec = -0.02;

t0 = 1;
pri = test_data(1);
vol = 5000/test_data(1);

current = 5000;
stock = 5000/test_data(1);

for t = 1:length(test_data)
    if length(pri) > 1
        if any(test_data(t)< pri * ( 1 + Rdec ))
            if current>0
                disp('Hit1')
                pri = [pri pri(end) * ( 1 + Rdec )];
                delta = min(1000,current);
                vol = [vol delta/pri(end)];
                current = current - delta;
                stock = stock + delta/pri(end);
            end
        end
        if any(test_data(t)> pri * ( 1 + Rinc ))
            
        else
        end
    else
    end
    
    
    if any(test_data(t)> pri * ( 1 + Rinc ))
        if stock > 0
            disp('Hit2')
            if length(vol)>1                
                delta = vol(end);
                current = current + delta * pri(end) * ( 1 + Rinc );
                stock = stock - delta;            
                pri = pri(1:end-1);
                vol = vol(1:end-1);
            else                 
                delta = min(1000,vol(1));
                current = current + delta * pri(end) * ( 1 + Rinc );
                stock = stock - delta;     
                vol(1) = vol(1) - delta;
            end
        end
    end    
end
output_args = 0;
end

