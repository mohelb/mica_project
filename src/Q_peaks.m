function [l] = Q_peaks(smw,m)
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
    if ( l(i) == 1)
        
    

    
end