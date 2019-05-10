function [R_pks, R_locs] = R_peaks(data, smw,Fs)
m=abs(mean(smw.*data));
for i=1:length(data)
    if (smw(i)*data(i)<m)
        data(i)=0;
    end
end
[R_pks,R_locs] = findpeaks(data,'MinPeakDistance',round(0.2*Fs));
end