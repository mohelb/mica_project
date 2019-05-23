function [smw]= Smw(data, Fs,N)
Ts = 1/Fs;

%band_pass filter:
bb=[1,0,0,0,0,0,-2,0,0,0,0,0,1];
ab=[1,-2,1];
[gdb,wb]=grpdelay(bb,ab);
mb=mean(gdb);
y=filter(bb,ab, data);
bh=[-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
ah=[1,-1];
y=filter(bh,ah,y);
[gd2,w2]=grpdelay(bh,ah);
mh=mean(gd2);

%differentiating filter:
bd=[1,2,0,-2,-1];
ad=8*Ts;
z=filter(bd,ad,y);
[gdd,wd]=grpdelay(bd,ad);
md=mean(gdd);

%the signal is squared:
z=z.*z;

%Moving window integration and normalization:
mwi = ones(1,0.16*Fs)/0.16*Fs;

%on le calcule a partir de wmi;
mWi=14.5; 
smw = conv(z,mwi);
m=abs(max(smw)/max(data));
smw=smw/m;

%smw threshold:
th=mean(smw);
for i=1:length(smw)
    if (smw(i)< th)
        smw(i)=0;
    end
end

%removing group delay:
mg = 37; 
smw=smw(37+(1:N-10));