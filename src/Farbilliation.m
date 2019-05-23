function [Gamma] = Farbilliation(Delta, Delta_barre)
N = length(Delta);
Gamma = zeros(1,N);

for k = 1:N
    for n = 1:N-k
        Gamma(k)= Gamma(k)+(1/(N-k-1))*(Delta(n+k)-Delta_barre)*(Delta(n)-Delta_barre);
    end
end

