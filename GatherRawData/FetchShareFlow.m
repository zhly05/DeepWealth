function shareFlowArray = FetchShareFlow(stockInfo)
    codebook = stockInfo.Stockcode;
    shareFlowArray = zeros(length(codebook),1);
    fprintf('Fetch flow: ');
    for i = 1:length(codebook)
        shareFlowArray(i) = FetchSingleShareFlow(codebook(i,3:8));
        if(shareFlowArray(i)==0 && isfield(stockInfo.preDefinedShare,codebook(i,:)))
            shareFlowArray(i) = stockInfo.preDefinedShare.(codebook(i,:));
        end
        if ~mod(i,100)
            fprintf('.');
        end
    end
    fprintf('Finish\r\n');
end

function shareFlow = FetchSingleShareFlow(code)    
    if code(1) == 's'
        url = ['http://stockpage.10jqka.com.cn/' code(3:8) '/holder/'];
    elseif code(1) == '6'
        url = ['http://stockpage.10jqka.com.cn/' code '/holder/'];
    elseif isnumeric(code)
        url = sprintf('http://stockpage.10jqka.com.cn/%06d/holder/',code);
    end
    done = 0;
    shareFlow = 0;
    while(done < 5)
        try
            raw_str = urlread(url);
            idx = strfind(raw_str,'��ͨA��</span></th>');
            [~,~,~,d,~] = regexp(raw_str(idx:idx+500),'>[0-9|.]+<');
            shareFlow = sscanf(d{1},'>%f<');
            done = 5;
        catch
            pause(1);
            done = done + 1;
            disp(['URL:' url])
        end
    end
end