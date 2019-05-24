function [patient_malady,ectopic_malady]= Ectopic_beat(Delta)

Ectopic_beat = [];

for i = 1: length(Delta)-1
    Ectopic_beat(i) = abs(Delta(i+1) - Delta(i));
end

thrace_ectopic = 20;
ectopic_malady=[];
for i = 1: length(Ectopic_beat)
    if (Ectopic_beat(i)> thrace_ectopic)
        ectopic_malady(i)= 1;
    else ectopic_malady(i) = 0;
    end
end

patient_malady = max(ectopic_malady);