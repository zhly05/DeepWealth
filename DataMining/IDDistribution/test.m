%run ../../Test_env.m
%%
%%
files = dir([Path_LocalData '*.mat']);
%%
binsX = -0.2:0.005:0.2;
tot_Hvec = zeros(1,length(binsX));
mat_Hvec = zeros(1061, length(binsX));
for f = 1:length(files)
    load([Path_LocalData files(f).name]);
    fNames = fieldnames(StockArrays);
    for i = 1:length(fNames)
        todoCode = fNames{i};
        [~, hVec] = DistributeCore(StockArrays.(todoCode).items(:,3), StockArrays.(todoCode).items(1,2),2);
        tot_Hvec = tot_Hvec + hVec;
        mat_Hvec(i,:) = mat_Hvec(i,:) + hVec;
    end  
    tot_Hvec = tot_Hvec * 0.95;
    fprintf('.');
end
%%
subplot(1,3,1)

modi_vec = tot_Hvec;
modi_vec(abs(binsX)<=0.005) = 0;
stem(binsX,modi_vec)
modi_vec = modi_vec/sum(modi_vec);
n_cum = cumsum(modi_vec);
p_cum = cumsum(modi_vec(end:-1:1));
n_cum = n_cum(1:40);
p_cum = p_cum(40:-1:1);

subplot(1,3,2)
stem(binsX,[n_cum 0 p_cum])
subplot(1,3,3)
stem(binsX,[n_cum 0 p_cum].*abs(binsX))