%%%%%% control Ringer

function [na4,na5,na6] = Perf_n(na3,CO2)
global keq kh kd  
% CO2 is the precentage of CO2 concentration
na5 = CO2/100/29.41*1e+3;
pH = -log10(kh/kd*na5/na3/keq);
na4 = 10^(-pH);
na6 = na4*na3*keq;