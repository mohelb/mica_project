function [R_pks, R_locs] = R_peaks(data, smw, Fs)
m = 
for i=1:length(data)
    if (smw(i)*data(i)==0)
        data(i)=0;
    end
end
[R_pks,R_locs] = findpeaks(data,'MinPeakDistance',50);
end