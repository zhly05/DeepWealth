function [ output_args ] = AutoSell( code, price, volume )
%
    tempstr = sprintf('%s %.2f %d',code(end-5:end),price,volume);
    clipboard('copy', tempstr);
    KeyPress(114,'c');
end

