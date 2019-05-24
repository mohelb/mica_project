function [group_delay,smw]= Smw(data, Fs)
Ts = 1/Fs;
eps = 0.5;

if abs(mean(data)) < eps
    data = - data;
else
    data = data;
end

N = length(data); 
%band_pass filter:
%low-pass_?lter
b_low=[1,0,0,0,0,0,-2,0,0,0,0,0,1];
a_low=[1,-2,1];
[gd_low,w_low]=grpdelay(b_low,a_low);
delay_low=mean(gd_low);
%high-pass_?lter
y=filter(b_low,a_low, data);
b_hight=[-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
a_hight=[1,-1];
y=filter(b_hight,a_hight,y);
[gd_hight,w_hight]=grpdelay(b_hight,a_hight);
delay_hight=mean(gd_hight);

%differentiating filter:
b_differentiating=[1,2,0,-2,-1];
a_differentiating=8*Ts;
z=filter(b_differentiating,a_differentiating,y);
[gd_differentiating,w_differentiating]=grpdelay(b_differentiating,a_differentiating);
delay_differentiating=mean(gd_differentiating);

%the signal is squared:
z=z.*z;

%Moving window integration and normalization:
mwi = ones(1,0.16*Fs)/0.16*Fs;

%on le calcule a partir de wmi;
delay_mwi=14.5;  %using fvtool
smw = conv(z,mwi);


%smw threshold: %we cancel the data values below the thracehold
th=mean(smw);
for i=1:length(smw)
    if (smw(i)< th)
        smw(i)=0;
    end
end

%removing group delay:
group_delay = delay_low + delay_hight + delay_differentiating + delay_mwi;
group_delay = round(group_delay)
smw=smw(group_delay+(1:N-10));