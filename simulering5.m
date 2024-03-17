%simuleringsprogram polplaceringsregulator
N=15;
h = 1;
y_k = step(Gz_tot, N);

for k=0:N
   disp(y_k(k+1))
end

