%simuleringsprogram polplaceringsregulator
N=15;
h = 1;
%utsignal för test
y_k2 = step(Gz_tot, N);
%styrsignal för test
u_k2 = step(Uz, N);

%utsignal och styrsignal i samplingsdomän y(0) 
y_k = [0 0 0 0 0];
u_k = [0 0 0 0 0];
r_k = [0 0 0 0 0];

for k=0:N
   %disp(k)
   %disp(u_k2(k+1))
   
   %r(k)
   r_k(4) = r_k(3);
   r_k(3) = r_k(2);
   r_k(2) = r_k(1);
   r_k(1) = 1;

   %y(k)
   y_k(5) = y_k(4);
   y_k(4) = y_k(3);
   y_k(3) = y_k(2);
   y_k(2) = y_k(1);

   y_k(1) = 0.3336 * r_k(2) + 0.3064 * r_k(3) + 0.4 * y_k(2) - 0.0369 * y_k(3) - 0.0007823 * y_k(4) - 0.002318 * y_k(5);
   %disp(y_k(1))

   %u(k)
   u_k(5) = u_k(4);
   u_k(4) = u_k(3);
   u_k(3) = u_k(2);
   u_k(2) = u_k(1);
   u_k(1) = 0.4 * u_k(2) - 0.0369 * u_k(3) - 0.0007823 * u_k(4) - 0.002318 * u_k(5) + 43.9 * r_k(1) - 76.86 * r_k(2) + 33.62 * r_k(3);
   disp(u_k(1))
   
end

