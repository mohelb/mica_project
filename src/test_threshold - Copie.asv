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
%Pan and tompkins alogrithm
%band_pass filter:
bb=[1,0,0,0,0,0,-2,0,0,0,0,0,1];
ab=[1,-2,1];
y=filter(bb,ab, data);
bh=[-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
ah=[1,-1];
y=filter(bh,ah,y);
%differentiating filter avec retard de Z^(-2):
bd=[1,2,0,-2,-1];
ad=8*Ts;
z=filter(bd,ad,y);
%signal squared:
z=z.*z;
%Moving window integration:
h = ones(1,0.15*Fs)*3.5/(10^13);
z1 = conv(z,h);
%removing group delay
mg=23;
z1=z1(mg+[1:N]);
figure;
plot(data(Fs:3*Fs));
hold on;
plot(z1(Fs:3*Fs));











