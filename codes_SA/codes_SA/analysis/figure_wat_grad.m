clear all
close all

%%% to merge Y vectors in matfiles
load('X.mat');

load('hal_full.mat');

% Parameter Labels
%efast_var={'Ps1', 'Pp1','NBC12s','NBC12p','AEs','NHE','NKCC','Pp2','AEp','Ptj','CA_{cell}','CA_{PC}','dummy'};%,

efast_var={'$P^s_{K^+}$','$P^p_{K^+}$','$P_{NBC_s}$','$P_{NBC_p}$','$P_{AE_s}$','$P_{NHE}$','$P_{NKCC}$','$P^p_{Cl^-}$','$P_{AE_p}$','$P^{tj}$','dummy'};%,
cols=[7,5,9,4,3,6,1,2,8,10];
k=1:4;
[Si,Sti,rangeSi,rangeSti] = efast_sd_2(Y,OMi,MI,k);

figure
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaultLegendInterpreter','latex');
bar(1:10,[Sti(cols,k)])
set(gca,'xticklabel',efast_var(cols))
legend('Na$^+$','K$^+$','Cl$^-$','HCO$_3^-$')
title('Cell')
set(gca,'Fontsize',14)

k=9:12;
[Si,Sti,rangeSi,rangeSti] = efast_sd_2(Y,OMi,MI,k);

figure
bar(1:10,[Sti(cols,k)])
hold on 
plot(6.5*[1,1],[0,0.6],'k--')
set(gca,'xticklabel',efast_var(cols))
legend('Na$^+$','K$^+$','Cl$^-$','HCO$_3^-$')
title('PC')
set(gca,'Fontsize',14)
