[AX,H1,H2]=plotyy(simout(:,3),simout(:,2),simout(:,3),simout(:,1));
title('Photovoltaic Module Characteristics Curve');
set(H1,'LineWidth',2);
set(H2,'Color','r');
set(H2,'LineWidth',2);
set(get(AX(2),'Ylabel'),'String','Power in Watt','Color','r');
set(AX(2),'YColor','r');
set(AX(2),'ylim',[0 max(simout(:,1))*1.1]);
set(AX(2),'YTick',0:20:max(simout(:,1))*1.1);
set(AX(1),'YTick',0:1:max(simout(:,2))+1);
set(AX(2),'xlim',[0 simout(find(simout(:,2)<0,1),3)*1.1]);
set(AX(1),'xlim',[0 simout(find(simout(:,2)<0,1),3)*1.1]);
ylim([0 max(simout(:,2))+1]);
ind1 = find(simout(:,1)==max(simout(:,1)));
aPmp = simout(ind1,1);
aImp = simout(ind1,2);
aVmp = simout(ind1,3);

ind2 = find(simout(:,4)==max(simout(:,4)));
aPte = simout(ind2,4);
aIte = simout(ind2,5);
aVte = simout(ind2,6);

ind3 = find(simout(simout(:,2)>0), 1, 'last' );
aVoc = simout(ind3,3);
aIsc = simout(1,2);
aRat = (aVmp/aVoc)*100;

%calculated Isc Handbook-of-Photovoltaic-Science-and-Engineering.pdf page:302


G = str2double(get_param([gcs,'/G_'],'Value'));
Gn = 1000;


numPar = str2double(get_param([gcs,'/Npp_'],'Value')); 
numSer = str2double(get_param([gcs,'/Nss_'],'Value'));

dT_ = str2double(get_param([gcs,'/T_'],'Value')) - 25;
cIsc = numPar * Iscn * (G/Gn) * (1 + Ki * dT_);

an = 1.3; % 1.3 has been suggested for monocrystalline and polycrystalline PV modules [11].
a = an;
Vt = 1.3806503e-23 * 36 * (str2double(get_param([gcs,'/T_'],'Value')) + 273.15) / 1.60217646e-19;
Vt_a = a * Vt; % modified diode ideality factor 

cVoc = numSer * Vocn + Kv*dT_ + Vt_a*log(G/Gn);


X = [get_param([gcs,'/G_'],'Value'),' ',get_param([gcs,'/T_'],'Value'),' ',num2str(aVmp),' ',num2str(aImp),' ',num2str(aPmp),' ',num2str(aPte),' ',num2str(aIte),' ',num2str(aVte)];

disp(X);
%xlabel(X);
xl = xlabel(X, 'FontSize', 9);
%get(xl);
ylabel('Current');
grid on;