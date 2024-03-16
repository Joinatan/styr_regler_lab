
V1 = 6;
V2 = 10;
Vr = 2;
Q = 1;
p = 0.997;
c = 4180;
k_u = 1/(Q * c * p);
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

