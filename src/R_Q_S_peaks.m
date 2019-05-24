function [A,B,R_locs,Q_locs,S_locs] = R_Q_S_peaks(data,smw)

% Porte avec 1 si smw(i) > m et 0 sinon.
l = smw;
m = mean(smw);
for i=1:length(smw)
    if (smw(i)<m)
        l(i)=0;
    else
        l(i) = 1;
    end

end

% 
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
S_locs = [];R_locs = [];

for i=1:length(A)-1
    
    R = max(data( A(i): B(i) ));
    R_locs(i) = find( data == R ) ;
    j = R_locs(i);

    
    % finding the first minimum before R
    k=1;
    min = R;
    while data(j-k-1)< data(j-k)
        min = data(j-k-1);
        k=k+1;
    end
    
    Q_locs(i) = find( data == min ) ;
    
    % finding the first minimum after R
    min = R;
    k=1;
     while data(j+k+1)< data(j+k)
        min = data(j+k+1);
        k=k+1;
     end
    S_locs(i) = find( data == min ) ;
    

end

end