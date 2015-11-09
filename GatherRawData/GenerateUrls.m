function [urls] = GenerateUrls()
% Generate URLs.txt and Stockcode.mat
    PackageN = 700;
    [~, Idx, Stockcode,Stockname] = ScanForValidCode(PackageN);
    StockN = length(Idx);
    PageN = floor(StockN / PackageN) + 1;
    urls = cell(PageN,1);
    SperPage = ones(PageN,1) * ceil(StockN / PageN);
    temps = 1;
    fid = fopen('URLs.txt','w');
    for j = 1:PageN
        tempe = min(temps + SperPage(1) - 1,StockN);   
        StockcodeUrl{j} = Stockcode(temps:tempe,:);
        urls{j} = ['http://hq.sinajs.cn/list=' reshape(strcat(Stockcode(temps:tempe,:),',')',1,[])];
        fprintf(fid,'%s\r\n',urls{j});
        temps = tempe + 1;    
    end
    fclose(fid);
    SperPage(end) = mod(StockN-1, SperPage(1))+1;
    startIdx = cumsum([1;SperPage(1:end-1)]);
    endIdx = cumsum(SperPage);
    save('Stockcode.mat','Idx','Stockcode','Stockname','StockcodeUrl','startIdx','endIdx','SperPage');
end



function [pointers,idx,stockcode,stockname] = ScanForValidCode(packsize)
% Scan which stocks data can be gathered.
% url_size: max number of stock codes can be sent in one url
% from 0:maxN-1 + sh600000
    n = 0;
    maxN = 6000;  % 0 : max-1
    pointers = zeros(maxN,1);
    stockname = cell(maxN,1);
    while(n<maxN)
        try_code = cell(1,packsize);
        for i = 1:packsize
            try_code{i} = sprintf('sh60%04d,',n);
            n = n + 1;
            if n == maxN
                break;
            end
        end
        to_send = strcat('http://hq.sinajs.cn/list=',try_code{:});
        for i = 1:5
            try
                cont_str = urlread(to_send);
                cont_cell = strsplit(cont_str,'";');
                break;
            catch e
                ErrorLog(e);
                pause(1);
            end
        end
        cont_cell{1} = [' ' cont_cell{1}];
        for i = 1:length(cont_cell)
            if length(cont_cell{i})> 22
                pointers(str2double(cont_cell{i}(16:20))+1) = 1;
                stockname{str2double(cont_cell{i}(16:20))+1} = cont_cell{i}(23:26);
            end
        end
    end
    idx = find(pointers == 1)-1;
    stockcode = reshape(sprintf('sh60%04d',idx),8,[])';
    pointers = pointers(1:idx(end)+1);
    stockname = stockname(pointers==1);
end