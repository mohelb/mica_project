function [ectopic_malady, Ectopic_beat]= Ectopic_beat(Delta)

Ectopic_beat = [];

for i = 1: length(Delta)-1
    Ectopic_beat(i) = Delta(i+1) - Delta(i);
end

thectopic = 20;
ectopic_malady=[];
for i = 1: length(Ectopic_beat)
    if (Ectopic_beat(i)> thectopic)
        ectopic_malady(i)= 1;
    else ectopic_malady(i) = 0;
    end
end

malady = find(ectopic_malady ==1);