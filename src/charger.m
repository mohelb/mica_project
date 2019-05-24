function [data,Fs,Ts,N,time_axis] = charger()
    [file,path] = uigetfile('*.mat', 'rt');
    signal = load(fullfile(path, file));
    data = signal.ecg; % Your ecg data
    Fs = signal.Fs; % Sampling frequency
    Ts=1/Fs;
    N = size(data,2); % Data length
    time_axis = (1:N)/Fs;
end