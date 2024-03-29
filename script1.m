
V1 = 6;
V2 = 10;
Vr = 2;
Q = 1;
p = 0.997;
c = 4180;
k_u = 1000/(Q * c * p);
k_v = 1;
s = tf('s');

G1 = 1/((V1/Q)*s + 1);
G2 = exp((-Vr/Q)*s);
G3 = 1/(1+(V2/Q)*s);
Gtot = G1 * G2 * G3;
V_s = 1/s;
U_s = 1000/s;
Y_U = k_u* Gtot;
Y_V = k_v * Gtot;


Y = U_s * k_u * Gtot + V_s * k_v * Gtot;

sys = Gtot/(1+Gtot);

k_0 = 7.76;
t_0 = 17.59;
P = 0.6 * k_0;
Ti = 0.5 * t_0;
Td = 0.125 * t_0;

%Discrete time
h = 1;
z = tf('z', h);
Gd = c2d(Gtot, h);
P_z = (1-0.5*z^(-1))^4;
%C_z = 1 + c_1 * z^(-1);
syms c_1 d_0 d_1 d_2 Z;
B = 0.00698 * Z^(-2) + 0.0076*Z^(-1);
A = 0.769 * Z^(-2) - 1.751 * Z^(-1) + 1;
P = (1 - 0.2 * Z^(-1))^2;
C = (1 + c_1 * Z^(-1)) * (1-Z^(-1));
D = d_0 + d_1 * Z^(-1) + d_2 * Z^(-2);
tutti = A * C + B * D;
eqn =  1 == (A * C + B * D)/P;

%rakna ut koefficienter i polynom C och D

z1 = -1 + c_1 - (1751/1000) + d_0 * (19/2500) == -0.4;
z2 = -c_1 + (1751/1000) - c_1 * (1751/1000) + (769/1000) + d_1 * (19/2500) + d_0 *(349/50000) == 0.04;
%z1 = -1 + c_1 - (1751/1000) + d_0 * (19/2500) == -1.2;
%z2 = -c_1 + (1751/1000) - c_1 * (1751/1000) + (769/1000) + d_1 * (19/2500) + d_0 *(349/50000) == 0.36;
z3 = c_1*(1751/1000) - (769/1000) + c_1 * (769/1000) + d_2 * (19/2500) + d_1* (349/50000) == 0;
z4 = -c_1 *(769/1000) + d_2 * (349/50000) == 0;
eqns = [z1 z2 z3 z4];
solutions = solve(eqns);
c1 = double(solutions.c_1);
d0 = double(solutions.d_0);
d1 = double(solutions.d_1);
d2 = double(solutions.d_2);
Cz = (1 + c1 * z^(-1)) * (1 - z^(-1));
Dz = d0 + d1 * z^(-1) + d2 * z^(-2);
k_r = 0.64/0.01458;
%k_r = 0.16 / 0.01458;
Bz = 0.00698 * z^(-2) + 0.0076 * z^(-1);
Az = 0.7659 * z^(-2) - 1.751 * z^(-1) + 1;

%totala overforingsfunktionen med polplaceringsregulator
Gz_tot = k_r * (Bz / (Az * Cz + Bz * Dz));
%styrsignalen
Uz = (k_r * Az)/(Az * Cz + Bz * Dz);



%symbliska varianter (strunta i dessa)
BZ = 0.00698 * Z^(-2) + 0.0076 * Z^(-1);
AZ = 0.7659 * Z^(-2) - 1.751 * Z^(-1) + 1;
CZ = (1 + c1 * Z^(-1)) * (1 - Z^(-1));
DZ = d0 + d1 * Z^(-1) + d2 * Z^(-2);
GZ_tot = k_r * (BZ / (AZ * CZ + BZ * DZ));
syms n;
Gk = iztrans(GZ_tot, Z, n);


