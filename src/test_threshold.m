%% Main script to test ecg function without gui
% This file computes a simple analysis of an ecg signal. You can use it to test the different processing methods. 
% This first version will plot the temporal signal, compute its cardiac rythma and display the different P, Q, R, S, T points for a specific segment.  

clear; close all; clc;
% addpath(genpath(data = data(1:term*Fs);'.'));

%% Load a signal
[data,Fs,Ts,N,time_axis] = charger();
figure;
spectrogram(data)
%% Our method for QRS detection! 

[mg,smw] = Smw(data,Fs);

%finding R Q and S peaks:
[R_locs,Q_locs,S_locs] = R_Q_S_peaks(data,smw);

%the axis are then transformed to second
Q_locs_sec = Q_locs/Fs;
R_locs_sec = R_locs/Fs;
S_locs_sec = S_locs/Fs;

%default window start and end
window_start = 1;
window_end = 4;

%% plot
index_start=1;
while(Q_locs_sec(index_start) <= window_start)
    index_start = index_start + 1;
end
[nb_peaks, data_window] = window(data,Fs,window_start,window_end,Q_locs_sec);
plot(time_axis(window_start*Fs:window_end*Fs),data_window);
hold on;
plot(Q_locs_sec(index_start:index_start+nb_peaks-1),data(Q_locs(index_start:index_start+nb_peaks-1)),'*');
plot(S_locs_sec(index_start:index_start+nb_peaks-1),data(S_locs(index_start:index_start+nb_peaks-1)),'*');
plot(R_locs_sec(index_start:index_start+nb_peaks-1),data(R_locs(index_start:index_start+nb_peaks-1)),'o');

[btm,m] = beats(R_locs_sec);
%% Automatic identication of cardiac pathologies
%Spectogram Analysis:
%spectrogram(data,8);

%Tachycardia/Bradycardia:
[Delta, Delta_barre,Arrythmie]= Arrythmia(R_locs_sec);
%Ectopic beat:
[patient_malady,ectopic_malady]= Ectopic_beat(Delta);
%Fibrillation:
[Gamma] = Farbilliation(Delta, Delta_barre);








    













