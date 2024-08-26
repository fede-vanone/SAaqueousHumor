%%% script for the solution 

syms np0 np1 np2 np3 nc0 nc1 nc2 nc3 Xx Vs Vp 
%% fluxes
Kna = 0.2*(1 + nc1/(8.38)); Kk = 0.1*(1 + np0/(18.5));

% active
Pump = P*(nc0/(nc0 + Kna))^3*(np1/(np1 + Kk))^2;
Cotr = M*log(nc0*nc1*nc2^2/ns0/ns1/ns2^2);

NBC2 = PNaBic12*(log(nc0*nc3^2/ns0/ns3^2)-Vs);% + out of the cell
NBC1 = 0*PNaBic11*(log(nc0*nc3/ns0/ns3));
NBC2p = PNaBic12p*(log(nc0*nc3^2/np0/np3^2)-Vp);% + out of the cell

AEp = PClBicp*log(np2*nc3/nc2/np3); % + for Bic - for Cl
AEs = PClBics*log(ns2*nc3/nc2/ns3); % + for Bic - for Cl

% passive
J1s = Ps1*Vs*(nc1 - ns1*exp(-Vs))/(1 - exp(-Vs));
J1p=Pp1*Vp*(nc1 - np1*exp(-Vp))/(1 - exp(-Vp));
J2p=-Pp2*Vp*(nc2 - np2*exp(Vp))/(1 - exp(Vp));

% tj 
J0tj = Ptj*(Vp-Vs)*(ns0 - np0*exp(-(Vp-Vs)))/(1 - exp(-(Vp-Vs)));

u=-Kp*(nc0+nc1+nc2+nc3+Xx - np0 - np1 - np2 - np3);

%% equations
% balance in the cell
eq1 = 3*Pump + Cotr + NBC2 + NBC1 + NBC2p  == 0; % 5a - 0
eq2 = J1p - 2*Pump + Cotr + J1s == 0; % 5a - 1
eq3 = 2*Cotr + J2p - AEp -AEs  == 0; % 5a - 2
eq4 = AEp + AEs + 2*NBC2 + NBC1 + 2*NBC2p== 0; 

% balance in the PC
eq5 = 3*Pump + NBC2p+ J0tj- u*np0 == 0 ; % 
eq6 = -2*Pump  + J1p - u*np1 == 0;
eq7 = J2p - AEp  - u*np2 == 0;
eq8 = 2*NBC2p+ AEp - u*np3 == 0;


% water balance
eq9 = Ks*(ns0 + ns1 + ns2 + ns3 - nc0 - nc1 - nc2 - nc3 - Xx)== Kp*(nc0 + nc1 + nc2 + nc3 + Xx - np0 - np1 - np2 - np3);

% electroneitrality 5g
eq11 = np0 + np1 - np2 - np3 ==0; 
eq12 = nc0 + nc1 - nc2 - nc3 - zx*Xx == 0;


eqns=[eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8 eq9 eq11 eq12];
vars = [np0 np1 np2 np3 nc0 nc1 nc2 nc3 Xx Vs Vp];
incon = [ns0,ns1,ns2,ns3,20,133,20,ns3,90,-2.5,-2.7];
range = [ 50 200; 0.1 70; 50 200; 0.1 100; 0.1 100; 50 200; 1 150; 0.1 100; 1 200; -5,1; -5,1];
clear sol;

sol = vpasolve(eqns,vars,incon);
sol.np0
if isreal(sol.np0)==1 && isreal(sol.Vs)==1 && isempty(sol.nc0)==0

np0=double(sol.np0);
np1=double(sol.np1);
np2=double(sol.np2);
np3=double(sol.np3);
nc0=double(sol.nc0);
nc1=double(sol.nc1);
nc2=double(sol.nc2);
nc3=double(sol.nc3);
Vs=double(sol.Vs);
Vp=double(sol.Vp);
TEP=Vs-Vp;
Xx=double(sol.Xx);
u=Kp*(-(nc0+nc1+nc2+nc3+Xx - np0 - np1 - np2-np3))/epsilon;
JNa=u*np0;
JK=u*np1;
JCl=u*np2;
JBic=u*np3;
else
   np0=NaN; np1=NaN; np2=NaN; np3=NaN; Xx=NaN; nc0=NaN; nc1=NaN; nc2=NaN; nc3=NaN; Vs=NaN;
   Vp=NaN; TEP=NaN; u=NaN; JNa=NaN; JK=NaN; JCl=NaN; JBic=NaN; 
end
    