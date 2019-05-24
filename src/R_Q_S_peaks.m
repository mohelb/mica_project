function [R_locs,Q_locs,S_locs] = R_Q_S_peaks(data,smw)
%detecting the type of the signal
eps = 0.5;
if abs(mean(data)) < eps
    data = - data;
else
    data = data;
end

% window equal to 1 if smw(i) > m and 0 if not.
l = smw;
m = mean(smw);
for i=1:length(smw)
    if (smw(i)<m)
        l(i)=0;
    else
        l(i) = 1;
    end

end

%defining the start and the end of the QRS complexe
flag = 0;
L=[];
for i=1:length(l)
    if (l(i) == 1 & flag == 0)
            L=[L,i];
            flag = 1;
    elseif (l(i) == 0 & flag == 1)
            L=[L,i];
            flag = 0;
    end
    
end

%the start of the complexe
A = L(1:2:end-1);
%the end of the complexe
B = L(2:2:end);

Q_locs = [];
S_locs = [];R_locs = [];

%finding  Q, R, S locs
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