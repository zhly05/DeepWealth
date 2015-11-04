function [detailed] = volumehold(arrays, code)
    this_array = arrays.(code);
    t = this_array.timearray;
    pri = this_array.items(:,3);
    pri_m = this_array.items(:,11:2:29);
    vol_m = this_array.items(:,10:2:28);
    Nt = length(t);
    [pricelist,~,indexM2L] = unique(pri_m);
    Np = length(pricelist);
    volumelist = zeros(Nt,Np);
    volumelist(1,indexM2L(1:Nt:end)) = vol_m(1,:);
    for it = 2:Nt
        volumelist(it,:) = volumelist(it-1,:);
        volumelist(it,indexM2L(it:Nt:end)) = vol_m(it,:);
    end
    detailed.volumelist = volumelist;
    detailed.pricelist = pricelist;
    
    
    %%
    
    MAXV = max(max(vol_m));
    %vol_m = sqrt(sqrt(vol_m/MAXV));
    MAXV = 0;
    hold off;
    plot(t,pri)
    hold on;
    % t=-5
    t1 = -5;
    t2 = (t(1)+t(2))/2;
    for i = 1:(length(t)-1)
        t2 = (t(i)+t(i+1))/2;
        MAXV = max(MAXV,max(volumelist(i,:)));
        temp_vol = volumelist(i,:)/MAXV;
        for j = 1:Np
            rect = [t1,pricelist(j)-0.005,(t2-t1),0.01];
            colorv = [1,0,0]*(temp_vol(j))+[1,1,1]*(1-temp_vol(j));
            rectangle('position',rect,'facecolor',colorv,'linestyle','none');
        end
        t1 = t2;
    end
    plot(t,pri,'b')
    ylim([pri(1)*0.9,pri(1)*1.1]);
    xlim([0,20000]);
    set(gca,'xtick',(0:12)*1800);
end