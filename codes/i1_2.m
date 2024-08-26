clear;
close all;
global kd kh keq

load('X.mat') % call X file

Parameter_settings_EFAST; % call parameter file

Y(NS,length(y0),length(pmin),NR)=0;  % pre-allocation

for i=1:k
for Ll=1:NR
        for run_num=1:NS
            [i run_num Ll] % keeps track of [parameter run NR]
            % ODE system file
            [nc0,nc1,nc2,nc3,nc4,nc5,nc6,Xx,np0,np1,np2,np3,np4,np5,np6,Vp,Vs,TEP,u,JNa,JK,JCl,JBic]=model_main(X(:,:,i,Ll),run_num);
            % It saves only the desired output
            Y(run_num,:,i,Ll)=[nc0,nc1,nc2,nc3,nc4,nc5,nc6,Xx,np0,np1,np2,np3,np4,np5,np6,Vp,Vs,TEP,u,JNa,JK,JCl,JBic]'; % this is the output 
            save res.mat;
        end %run_num=1:NS
end % L=1:NR
end

save res.mat;
exit
