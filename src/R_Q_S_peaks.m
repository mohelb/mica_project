function [R_locs,Q_locs,S_locs] = R_Q_S_peaks(data,smw,m)
l = smw;
for i=1:length(smw)
    if (smw(i)<m)
        l(i)=0;
    else
        l(i) = 1;
    end

end

flag = 0;
L=[];
for i=1:length(l)
    if ( l(i) == 1 & flag == 0)
            L=[L,i];
            flag = 1;
    elseif ( l(i) == 0 & flag == 1)
            L=[L,i];
            flag = 0;
    end
    
end


A = L(1:2:end-1);
B = L(2:2:end);

Q_locs = [];
S_locs = [];
R_locs = [];

for i=1:length(A)-1
    
    R = max(data( A(i): B(i) ));
    R_locs(i) = find( data == R ) ;
    Q = min( data( A(i) : R_locs(i) ) );
    Q_locs(i) = find( data == Q ) ;
    S = min( data( R_locs(i) : B(i) ) );
    S_locs(i) = find( data == S ) ;
end

end