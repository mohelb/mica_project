%% Main script to test ecg function without gui
% This file computes a simple analysis of an ecg signal. You can use it to test the different processing methods. 
% This first version will plot the temporal signal, compute its cardiac rythma and display the different P, Q, R, S, T points for a specific segment.  

clear; close all; clc;
% addpath(genpath(data = data(1:term*Fs);'.'));

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

smw = Smw(data,Fs,N);

mini_data = data(1:N-10);

%finding R Q and S peaks:

m=150;

[R_locs,Q_locs,S_locs] = R_Q_S_peaks(Fs,data,smw,m);

Q_locs_sec = Q_locs/Fs;
R_locs_sec = R_locs/Fs;
S_locs_sec = S_locs/Fs;

window_start = 4;
window_end = 10;
nb_peaks = 0;
for i = 1:length(Q_locs_sec)
    if(Q_locs_sec(i)>= window_start)
        if(Q_locs_sec(i)<= window_end)
            nb_peaks = nb_peaks+1;
        end
    end
end
index_start=1;
while(Q_locs_sec(index_start)<= window_start)
    index_start=index_start+1;
end




data_window= data(window_start*Fs:window_end*Fs);
plot(time_axis(window_start*Fs:window_end*Fs),data_window);
hold on;
plot(Q_locs_sec(index_start:index_start+nb_peaks-1),data(Q_locs(index_start:index_start+nb_peaks-1)),'*');
plot(S_locs_sec(index_start:index_start+nb_peaks-1),data(S_locs(index_start:index_start+nb_peaks-1)),'*');
plot(R_locs_sec(index_start:index_start+nb_peaks-1),data(R_locs(index_start:index_start+nb_peaks-1)),'o');
hold on; 
hold on;
plot(time_axis(window_start*Fs:window_end*Fs),smw(window_start*Fs:window_end*Fs));

%% Automatic identication of cardiac pathologies

%Spectogram Analysis:
%spectrogram(data,8);

%Tachycardia/Bradycardia:
[Delta, Delta_barre,Arrythmia]= Arrythmia(R_locs,Ts);

%Ectopic beat:
[ectopic_malady, Ectopic_beat]= Ectopic_beat(Delta);
%Fibrillation:
[Gamma] = Farbilliation(Delta, Delta_barre);


















    













