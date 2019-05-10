function [L] = Q_peaks(smw,m)
l = smw;
for i=1:length(smw)
    if (smw(i)<m)
        l(i)=0;
    else
        l(i) = 1;
    end

end
flag = 0;
L=[];
for i=1:length(l)
    if ( l(i) == 1 & flag == 0)
            L=[L,i];
            flag = 1;
    elseif ( l(i) == 0 & flag == 1)
            L=[L,i];
            flag = 0;
    end
    
end