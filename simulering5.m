%simuleringsprogram polplaceringsregulator
N=15;
h = 1;
%utsignal
y_k = step(Gz_tot, N);
%styrsignal
u_k = step(Uz, N);

for k=0:N
   disp(k)
   disp(u_k(k+1))
end

