function shareFlowArray = FetchShareFlow(codebook)
    shareFlowArray = zeros(length(codebook),1);
    for i = 1:length(codebook)
        shareFlowArray(i) = FetchSingleShareFlow(codebook(i,3:8));
        if mod(i,100)
            disp(i)
        end
    end
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
            idx = strfind(raw_str,'Á÷Í¨A¹É</span></th>');
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