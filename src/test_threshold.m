% This first version will plot the temporal signal, compute its cardiac rythma and display the different P, Q, R, S, T points for a specific segment.

clear; close all; clc;

%% Load a signal
[data,Fs,Ts,N,time_axis] = charger();


%% Your turn : My new method !

smw = Smw(data,Fs);

eps = 10;

if abs(mean(data)) < eps
    data1 = - data;
else
    data1 = data;
end

smw = Smw(data1,Fs);

%finding R Q and S peaks:
m=150;
[R_locs,Q_locs,S_locs] = R_Q_S_peaks(Fs,data,smw,m);
Q_locs_sec = Q_locs/Fs;
R_locs_sec = R_locs/Fs;
S_locs_sec = S_locs/Fs;
window_start = 4;
window_end = 10;
[index_start, nb_peaks, data_window] = window(data,Fs,window_start,window_end,Q_locs_sec);
plot(time_axis(window_start*Fs:window_end*Fs),data_window);
hold on;
plot(Q_locs_sec(index_start:index_start+nb_peaks-1),data(Q_locs(index_start:index_start+nb_peaks-1)),'*');
plot(S_locs_sec(index_start:index_start+nb_peaks-1),data(S_locs(index_start:index_start+nb_peaks-1)),'*');
plot(R_locs_sec(index_start:index_start+nb_peaks-1),data(R_locs(index_start:index_start+nb_peaks-1)),'o');
hold on;
hold on;

%% Automatic identication of cardiac pathologies

%Spectogram Analysis:

%Tachycardia/Bradycardia:
[Delta, Delta_barre,Arrythmia]= Arrythmia(R_locs_sec);

%Ectopic beat:
[ectopic_malady, Ectopic_beat]= Ectopic_beat(Delta);
%Fibrillation:
[Gamma] = Farbilliation(Delta, Delta_barre);









%RR_disatance and QRS width
%https://courses.kcumb.edu/physio/ecg%20primer/normecgcalcs.htm
