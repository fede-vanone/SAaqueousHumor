function [nc0,nc1,nc2,nc3,nc4,nc5,nc6,Xx,np0,np1,np2,np3,np4,np5,np6,Vp,Vs,TEP,u,JNa,JK,JCl,JBic]=model_main(X,run_num)
global kd kh keq
Parameter_settings_EFAST;

Ps1 = X(run_num,1);
Pp1 = X(run_num,2);
PNaBic11 = 0;
PNaBic12 = X(run_num,3);
PNaBic12p = X(run_num,4);
PClBics = X(run_num,5);
PNaH=X(run_num,6);
M = X(run_num,7);
Pp2 = X(run_num,8);
PClBicp = X(run_num,9);
Ptj = X(run_num,10);
CA_cell = 1;
CA_pc = 1;
dummy = X(run_num,11);



ef16; % script to run with parameters above 

