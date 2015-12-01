function [ output_args ] = AutoBuy( code, price, volume )
%
    tempstr = sprintf('%s %.2f %d',code(end-5:end),price,volume);
    clipboard('copy', tempstr);
    KeyPress(113,'c');
end

