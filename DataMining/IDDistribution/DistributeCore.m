function [ res_vec , hist_vec] = DistributeCore( data_vec, settlement , rio_thsd )
%DISTRIBUTECORE Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3
    rio_thsd = 5;
end

idx_extrePoint = [0;diff([data_vec(1:end-1)]>[data_vec(2:end)])];
data_tranc = [data_vec(1);data_vec(idx_extrePoint~=0);data_vec(end)];
sum_inc = 0;
sum_dec = 0;

res_vec = [];
bins = -0.20:0.005:0.20;
if ~any(data_vec == 0)
    diff_tranc = diff(data_tranc);
    curr_ID = diff_tranc(1);
    for i = 1:length(diff_tranc)
        if curr_ID >= 0
            if diff_tranc(i) > 0
                sum_inc = sum_inc + diff_tranc(i);
            elseif diff_tranc(i) < 0
                if sum_dec + sum_inc > -rio_thsd * diff_tranc(i)
                    sum_dec = sum_dec + diff_tranc(i);
                else
                    curr_ID = -1;
                    res_vec = [res_vec;sum_inc+sum_dec];
                    sum_inc = 0;
                    sum_dec = diff_tranc(i);
                end
            end
        elseif curr_ID < 0

            if diff_tranc(i) < 0
                sum_dec = sum_dec + diff_tranc(i);
            elseif diff_tranc(i) > 0
                if sum_dec + sum_inc < -rio_thsd * diff_tranc(i)
                    sum_inc = sum_inc + diff_tranc(i);
                else
                    curr_ID = 1;
                    res_vec = [res_vec;sum_inc+sum_dec];
                    sum_inc = diff_tranc(i);
                    sum_dec = 0;
                end
            end

        end
    end
end
res_vec = [res_vec;sum_inc+sum_dec];
res_vec = res_vec/settlement;
hist_vec = hist(res_vec, bins);
end

