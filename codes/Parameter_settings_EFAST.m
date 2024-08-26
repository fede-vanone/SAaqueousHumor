%% PARAMETER INITIALIZATION
% set up max and mix matrices
%%folding factors

% Typical concentrations

%%% thermodynamical constants
F = 96485.332; 
R = 8.314;
T = 37 + 273;

cm=2e-11*R*T;  % m/s/mM hydrodynamic permeability of a membrane


area_cp = 6e-4; % m^2 area of the CP of the cat (!)
area_pc = 6e-3*0.7e-3*2*pi; % side area of the PC
epsilon = area_pc/area_cp; 
%Rc=mu/area_cp; Rp=Rc;%mu/area_pc*1e+10; % Pa*s/m^2 resistances - have no idea about the value. 
%Both multiplied by 10^10 to get reasonable scale for the pressure

L = 10^(-5); % length of the cell
H=6e-3; % length of the PC

delta = L/H; % length asect ratio
% Diffusion coefficients
D = 1.7*10^(-9); % diffusion coefficient for na, k cl


% scale for the velocity 
U = 5e-11/area_pc;

% reactions - from RPE paper
kd = 4.96e+5; % 1/s dehydration
kh = 1.45e+3; % 1/s hydration
keq = 5.3; % equillibrium constant for bicarb reaction mM

%permeabilities to water
fact = 20;
Af=10;
Ks = cm;
Kp = Ks*Af;
ktj=Ks/50;

% ion transport
P = 3e-7*fact;

% concentrations stroma
ns0= 150;
ns1 = 5;
ns3= 25;
ns2 = ns0+ns1-ns3;
%Ptj=1e-9; % permeability to Na of the TJ

Pp5 = 0.0015*Af; % taken from RPE paper atm
Pp6 = 1.28*1e-5*Af;
Ps5 = 0.0015;
Ps6 = 1.28*1e-5;

zx=1.5;

pmean = [2.5*1e-9*fact,% Ps1
    1.5*10^(-8)*fact, % Pp1
    0.3e-7*fact, % NBC12s
    0.5e-7*fact, % NBC12p
    2e-7*fact, % AEs
    1.7e-7*fact, % NHE
    0.5e-7*fact, % NKCC
    0.3*10^(-8)*fact, % Pp2
    0.2e-7*fact, % AEp
    3e-10*fact, % Ptj
    5];

pmax = pmean*1.75;
pmin = pmean*0.25; 

% Parameter Labels
efast_var={'Ps1', 'Pp1','NBC12s','NBC12p','AEs','NHE','NKCC','Pp2','AEp','Ptj','dummy'};%,

% PARAMETER BASELINE VALUES (in terms of mean values)
%%% Permeabilities
%pmean=(pmax+pmin)/2;


y0=1:23;

% Variables Labels
y_var_label={'nc0','nc1','nc2','nc3','nc4','nc5','nc6','X','np0','np1','np2','np3','np4','np5','np6','Vp','Vs','TEP','u','JNa','JK','JCl','JBic'};

