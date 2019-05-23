function [Delta,Delta_barre, Arrythmia]= Arrythmia(R_locs,Ts)

Delta = [];
for i = 1:length(R_locs)-1
    Delta(i) = (R_locs(i+1) - R_locs(i));
end  

Delta_barre = mean(Delta);
Arrythmia = Delta_barre*Ts;
end