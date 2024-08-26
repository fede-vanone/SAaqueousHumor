clear all
close all

%%% to merge Y vectors in matfiles
load('X.mat');

load('hal_full.mat');



for l=1:17
     for k=1:11
            for m=1:2
ind=isnan(Y(:,l,k,m));
MM(l,k,m)=mean(Y(~ind,l,k,m));
            end
        Mmc(l,k)=mean(MM(l,k,:));
     end
    MMp(l)=mean(Mmc(l,k));
end

% Parameter Labels
%efast_var={'Ps1', 'Pp1','NBC12s','NBC12p','AEs','NHE','NKCC','Pp2','AEp','Ptj','CA_{cell}','CA_{PC}','dummy'};%,
k=1:4;
[Si,Sti,rangeSi,rangeSti] = efast_sd_2(Y,OMi,MI,k);
%efast_var={'Ps1', 'Pp1','NBC12','AEs','NKCC','Pp2','AEp','Ptj','dummy'};%,

figure
bar(1:10,[Si(1:10,k)])
set(gca,'xticklabel',efast_var)
legend('Na','K','Cl','Bic')
title('Cell')
set(gca,'Fontsize',14)

k=9:12;
[Si,Sti,rangeSi,rangeSti] = efast_sd_2(Y,OMi,MI,k);
Si
figure
bar(1:10,[Si(1:10,k)])
set(gca,'xticklabel',efast_var)
legend('Na','K','Cl','Bic')
title('PC')
set(gca,'Fontsize',14)

k=18:19;
[Si,Sti,rangeSi,rangeSti] = efast_sd_2(Y,OMi,MI,k);
Si
figure
bar(1:10,[Si(1:10,k)])
set(gca,'xticklabel',efast_var)
legend('TEP','u')
set(gca,'Fontsize',14)
