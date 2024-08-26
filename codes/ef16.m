%%% 
global kd kh keq
[ns4,ns5,ns6] = Perf_n(ns3,5);

syms np0 np1 np2 np3 np4 np5 np6 nc0 nc1 nc2 nc3 nc4 nc5 nc6 Xx Vs Vp 
%% fluxes
Kna = 0.2*(1 + nc1/(8.38)); Kk = 0.1*(1 + np0/(18.5));

% active
Pump = P*(nc0/(nc0 + Kna))^3*(np1/(np1 + Kk))^2;
Cotr = M*log(nc0*nc1*nc2^2/ns0/ns1/ns2^2);

NBC2 = PNaBic12*(log(nc0*nc3^2/ns0/ns3^2)-Vs);% + out of the cell
NBC2p = PNaBic12p*(log(nc0*nc3^2/np0/np3^2)-Vp);% + out of the cell

NBC1 = 0*PNaBic11*(log(nc0*nc3/ns0/ns3));

AEp = PClBicp*log(np2*nc3/nc2/np3); % + for Bic - for Cl
AEs = PClBics*log(ns2*nc3/nc2/ns3); % + for Bic - for Cl

JNaH = PNaH*log(ns0*nc4/nc0/ns4);

% passive
J1s = Ps1*Vs*(nc1 - ns1*exp(-Vs))/(1 - exp(-Vs));
J1p=Pp1*Vp*(nc1 - np1*exp(-Vp))/(1 - exp(-Vp));
J2p=-Pp2*Vp*(nc2 - np2*exp(Vp))/(1 - exp(Vp));

% non charged

J5p=Pp5*(nc5-np5);
J6p=Pp6*(nc6-np6);
J5s=Ps5*(nc5-ns5);
J6s=Ps6*(nc6-ns6);

% tj 
J0tj = Ptj*(Vp-Vs)*(ns0 - np0*exp(-(Vp-Vs)))/(1 - exp(-(Vp-Vs)));
J1tj = Ptj*(Vp-Vs)*(ns1 - np1*exp(-(Vp-Vs)))/(1 - exp(-(Vp-Vs)));
J2tj = -Ptj*(Vp-Vs)*(ns2 - np2*exp((Vp-Vs)))/(1 - exp((Vp-Vs)));
J3tj = -Ptj*(Vp-Vs)*(ns3 - np3*exp((Vp-Vs)))/(1 - exp((Vp-Vs)));
J4tj = Ptj*(Vp-Vs)*(ns4 - np4*exp(-(Vp-Vs)))/(1 - exp(-(Vp-Vs)));

% reaction term
Rc = CA_cell*(kh*nc5 - kd*nc6);
Rp = CA_pc*(kh*np5 - kd*np6);
%2*delta*Ptj1*(-(Vb-Va))*(nb1 - na1*exp(Vb-Va))/(1 - exp(Vb-Va))

u=-Ks*(ns0 + ns1 + ns2 + ns3 - nc0 - nc1 - nc2 - nc3 - Xx);

%% equations
% balance in the cell
eq1 = 3*Pump + Cotr + NBC2 + NBC1 + NBC2p - JNaH  == 0; % 5a - 0
eq2 = J1p - 2*Pump + Cotr + J1s == 0; % 5a - 1
eq3 = 2*Cotr + J2p - AEp -AEs  == 0; % 5a - 2
eq4 = AEp + AEs + 2*NBC2 + NBC1 + 2*NBC2p - JNaH== 0; 
eq5 = J5p + J6p + J5s + J6s + JNaH == 0; % cons of charge
eq6 = J5p + J5s + L*Rc ==0;
eq7 = nc6 - keq*nc3*nc4 == 0;

% balance in the PC
eq8 = 3*Pump + NBC2p+ J0tj- u*np0 == 0 ; % 
eq9 = -2*Pump  + J1p +J1tj - u*np1 == 0;
eq10 = J2p - AEp +J2tj - u*np2 == 0;
eq11 = 2*NBC2p+ AEp + J3tj-J4tj- u*(np3-np4) == 0;
eq12 = J5p + J6p +J4tj - u*(np5+np6+np4) == 0;
eq13 = J5p - H*Rp - u*np5 ==0 ;
eq14 = np6 - keq*np3*np4 ==0;


% water balance
eq15 = Ks*(ns0 + ns1 + ns2 + ns3 - nc0 - nc1 - nc2 - nc3 - Xx)== Kp*(nc0 + nc1 + nc2 + nc3 + Xx - np0 - np1 - np2 - np3)+ktj*(ns0 + ns1 + ns2 + ns3 - np0 - np1 - np2 - np3);

% electroneitrality 5g
eq16 = np0 + np1 - np2 - np3 ==0; 
%eq11 = J1s == NBC2;
%eq11= Vp==Vs+0.1;
eq17 = nc0 + nc1 - nc2 - nc3 - zx*Xx == 0;

tic
eqns=[eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8 eq9 eq10 eq11 eq12 eq13 eq14 eq15 eq16 eq17];
vars = [np0 np1 np2 np3 np4 np5 np6 nc0 nc1 nc2 nc3 nc4 nc5 nc6 Xx Vs Vp];
incon = [ns0,ns1,ns2,ns3,ns4, ns5,ns6,20,133,20,ns3,ns4,ns5,ns6,90,-2.6,-2.8];
%range = [ 50 200; 0.1 70; 50 200; 0.1 100; 0.1 100; 50 200; 1 150; 0.1 100; 1 200; -5,1; -5,1];
clear sol;


sol = vpasolve(eqns,vars,incon);
toc

if isreal(sol.np0)==1 && isreal(sol.Vs)==1 && isempty(sol.nc0)==0

np0=double(sol.np0);
np1=double(sol.np1);
np2=double(sol.np2);
np3=double(sol.np3);
np4=double(sol.np4);
np5=double(sol.np5);
np6=double(sol.np6);
nc0=double(sol.nc0);
nc1=double(sol.nc1);
nc2=double(sol.nc2);
nc3=double(sol.nc3);
nc4=double(sol.nc4);
nc5=double(sol.nc5);
nc6=double(sol.nc6);
Vs=double(sol.Vs);
Vp=double(sol.Vp);
TEP=Vs-Vp;
Xx=double(sol.Xx);
u=-Ks*(ns0 + ns1 + ns2 + ns3 - nc0 - nc1 - nc2 - nc3 - Xx)/epsilon;
JNa=u*np0;
JK=u*np1;
JCl=u*np2;
JBic=u*np3;
else
   np0=NaN; np1=NaN; np2=NaN; np3=NaN; np4=NaN; np5=NaN; np6=NaN; Xx=NaN; nc0=NaN; nc1=NaN; nc2=NaN; nc3=NaN; nc4=NaN; nc5=NaN;  nc6=NaN; Vs=NaN;
   Vp=NaN; TEP=NaN; u=NaN; JNa=NaN; JK=NaN; JCl=NaN; JBic=NaN; 
end


