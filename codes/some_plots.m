clear all
close all

%%% to merge Y vectors in matfiles
load('X.mat');

%check sampling of parameter k vs parameter m

k=5;
m=9;

figure
plot(X(:,k,k,1),X(:,m,k,1),'o')
hold on 
plot(X(:,k,k,3),X(:,m,k,3),'o')
xlabel(efast_var(k))
ylabel(efast_var(m))

load('hal_full.mat','Y');

l=14; % which parameter we are looking at
for k=1:11
    for l=19
ind1=isnan(Y(:,1,k,1));
ind2=isnan(Y(:,1,k,2));
ind3=isnan(Y(:,1,k,3));

p = polyfit([X(~ind1,k,k,1);X(~ind2,k,k,2);X(~ind3,k,k,3)],[Y(~ind1,l,k,1);Y(~ind2,l,k,2);Y(~ind3,l,k,3)],2);
%p = polyfit([X(~ind1,k,k,1);X(~ind2,k,k,2);X(~ind3,k,k,3)],[Y(~ind1,l,k,1);Y(~ind2,l,k,2);Y(~ind3,l,k,3)],2);

figure
plot(X(:,k,k,1),Y(:,l,k,1),'o')
hold on 
plot(X(:,k,k,2),Y(:,l,k,2),'o') 
plot(X(:,k,k,3),Y(:,l,k,3),'o') 

%semilogx(10.^X(:,k,k,4),Y(:,l,k,4),'o') 
plot(sort(X(:,k,k,1)),polyval(p,sort(X(:,k,k,1))),'k-') 
% plot(X(ind1,k,k,1),zeros([1,length(find(ind1))]),'o')
% plot(X(ind2,k,k,2),zeros([1,length(find(ind2))]),'o')
% % plot(X(ind3,k,k,3),zeros([1,length(find(ind3))]),'o')
% 
%ylim([-2.5e-13,0.5e-13])
% xlabel(efast_var(k)+", mol/m^2/s",'Fontsize',16)
% ylabel('F_{TOT}, m/s','Fontsize',14)
set(gca, 'FontSize', 16)
xlabel( efast_var(k)+ " (m s$^{-1}$)", 'FontSize',16,'Interpreter','LaTex')

%xlabel( efast_var(k)+ ", mol/m$^2$/s", 'FontSize',16,'Interpreter','LaTex')
ylabel(y_var_label(l),'FontSize',16,'Interpreter','LaTex')
saveas(gcf,char(num2str(k)),'epsc')
    end
end
