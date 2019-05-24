function [Delta,Delta_barre, Arrythmie]= Arrythmia(R_locs_sec)

Delta = [];
for i = 1:length(R_locs_sec)-1
    Delta(i) = (R_locs_sec(i+1) - R_locs_sec(i));
end  

Delta_barre = mean(Delta);
Arrythmie = Delta_barre;
end