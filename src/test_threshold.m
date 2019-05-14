%% Main script to test ecg function without gui
% This file computes a simple analysis of an ecg signal. You can use it to test the different processing methods. 
% This first version will plot the temporal signal, compute its cardiac rythma and display the different P, Q, R, S, T points for a specific segment.  

clear; close all; clc;
addpath(genpath('.'));

%% Load a signal
[file,path] = uigetfile('*.mat', 'rt');
signal = load(fullfile(path, file));
data = signal.ecg; % Your ecg data
Fs = signal.Fs; % Sampling frequency
Ts=1/Fs;
N = size(data,2); % Data length
time_axis = (1:N)/Fs;

% %% Threshold method
% % to be modified, the way we choose th and i_seg is very simple and not
% % fiable.
% th = 200; % threshold
% i_seg = 10; % Segment number to plot
% 
% % Time plot
% figure;
% plot(time_axis, data); grid on;
% hold on; plot(time_axis, th*ones(1,N), 'red');
% xlabel('Time (s)');
% ylabel('Magnitude');
% title('Time evolution of the loaded signal')
% 
% % Print BPM
% [bpm, R_locs] = bpm_threshold(data, th, Fs);
% % Figures PQRST
% [segment, P_loc, Q_loc, R_loc, S_loc, T_loc] = ecg_threshold(data, R_locs, i_seg);
% time_segment = (1:length(segment))/Fs;
% 
% figure;
% h = plot(time_segment, segment); grid on;
% hold on;
% plot(time_segment(P_loc),segment(P_loc), '*','Color','red'); text(time_segment(P_loc),segment(P_loc),' P ','Color','red','FontSize',14);
% plot(time_segment(Q_loc),segment(Q_loc), '*','Color','red'); text(time_segment(Q_loc),segment(Q_loc),' Q ','Color','red','FontSize',14);
% plot(time_segment(R_loc),segment(R_loc), '*','Color','red'); text(time_segment(R_loc),segment(R_loc),' R ','Color','red','FontSize',14);
% plot(time_segment(S_loc),segment(S_loc), '*','Color','red'); text(time_segment(S_loc),segment(S_loc),' S ','Color','red','FontSize',14);
% plot(time_segment(T_loc),segment(T_loc), '*','Color','red'); text(time_segment(T_loc),segment(T_loc),' T ','Color','red','FontSize',14);
% hold off;
% xlabel('Time (s)');
% ylabel('Magnitude');
% title('ECG segment characteristic')



%% Your turn : My new method ! 


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
mwi = ones(1,0.15*Fs)/0.15*Fs;

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
data = data(1:N-10);

%finding R Q and S peaks:

m=150;

[R_locs,Q_locs,S_locs] = R_Q_S_peaks(data,smw,m);

plot(data);
hold on;
plot(Q_locs,data(Q_locs),'*');
plot(S_locs,data(S_locs),'*');
plot(R_locs,data(R_locs),'o');

%% Automatic identification of cardiac pathologies

%Spectogram Analysis:
%spectrogram(data,8);

%Tachycardia/Bradycardia:
Delta = [];
for i = 1:length(R_locs)-1
    Delta(i) = (R_locs(i+1) - R_locs(i));
end  
Arrythmia = mean(Delta*Ts)

%Ectopic beat










    













