function [btm,m] = beats(R_locs_sec)  

m = length(R_locs_sec);
btm = round(60 *  m/R_locs_sec(m));
 
end

