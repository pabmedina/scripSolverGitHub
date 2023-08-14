%% Plots de Presion del nodo bomba vs tiempo.


if ~exist('temporalProperties.nTimes','var')
    temporalProperties.nTimes=iTime-1;
end


indiceTiempo = temporalProperties.drainTimes+1:temporalProperties.nTimes;
tiempo = cumsum(temporalProperties.deltaTs(indiceTiempo));
%- Plot: Presion nodo bomba calculado por FEA.
pFEA = zeros(1,temporalProperties.nTimes);
for i=1:size(bombaProperties.nodoBomba,1)
    for iTime = 1:temporalProperties.nTimes
        pTime           = dTimes(paramDiscEle.nDofTot_U+1:paramDiscEle.nDofTot_U+paramDiscEle.nDofTot_P,iTime)*temporalProperties.preCond;
        pFEA(iTime,i)     = pTime(bombaProperties.nodoBomba(i));    % Presion en el nodo Bomba calculada por FEA en cada iTime.
    end
end
% Presion vs tiempo durante proceso de fractura.
figure;hold on
% subplot(1,3,1)
% iTimeInicioISIP = sum(tiempo<=temporalProperties.tInicioISIP)+temporalProperties.drainTimes;
% scatter(tiempo(1:iTimeInicioISIP-temporalProperties.drainTimes),pFEA(temporalProperties.drainTimes+1:iTimeInicioISIP)*1e6/6894.76);
% title('Presion durante fractura')
% ylabel('Presion FEA [Psi]')
% % xlabel('tiempo [s]')
% minimo = min(pFEA(temporalProperties.drainTimes+1:iTimeInicioISIP))*1e6/6894.76;
% maximo = max(pFEA(temporalProperties.drainTimes+1:iTimeInicioISIP))*1e6/6894.76;
% ylim([minimo maximo])
% xlim([0 temporalProperties.tInicioISIP])
% grid
% % Presion vs tiempo con bomba apagada.
% subplot(1,3,2)
iTimeInicioISIP = sum(tiempo<=temporalProperties.tInicioISIP)+temporalProperties.drainTimes;
iTimeFinalISIP = sum(tiempo<=temporalProperties.tFinalISIP)+temporalProperties.drainTimes;
% plot(tiempo(iTimeInicioISIP-temporalProperties.drainTimes:iTimeFinalISIP-temporalProperties.drainTimes),pFEA(iTimeInicioISIP:iTimeFinalISIP)*1e6/6894.76,'bo');
plot(tiempo(iTimeInicioISIP+1-temporalProperties.drainTimes:iTimeFinalISIP-temporalProperties.drainTimes),pFEA(iTimeInicioISIP+1:iTimeFinalISIP,1)*1e6/6894.76,'r','lineWidth',2);
plot(tiempo(iTimeInicioISIP+1-temporalProperties.drainTimes:iTimeFinalISIP-temporalProperties.drainTimes),pFEA(iTimeInicioISIP+1:iTimeFinalISIP,2)*1e6/6894.76,'g','lineWidth',1);
plot(tiempo(iTimeInicioISIP+1-temporalProperties.drainTimes:iTimeFinalISIP-temporalProperties.drainTimes),pFEA(iTimeInicioISIP+1:iTimeFinalISIP,3)*1e6/6894.76,'b');



title('Presion con bomba apagada')
% ylabel('Presion FEA [Psi]')
xlabel('tiempo [s]')
minimo = min(pFEA(iTimeInicioISIP:iTimeFinalISIP))*1e6/6894.76;
maximo = max(pFEA(iTimeInicioISIP:iTimeFinalISIP))*1e6/6894.76;
% ylim([minimo maximo])
% xlim([temporalProperties.tInicioISIP, temporalProperties.tFinalISIP])
grid


T = readtable('Injection Test ITBA.xlsx');

plot(table2array(T(138:200,1))-45,table2array(T(138:200,6))-1152-23,'k')

legend('Fea1','Fea2','Fea3','Data');
% Presion vs tiempo durante produccion.
% subplot(1,3,3)
% iTimeFinalISIP = sum(tiempo<=temporalProperties.tFinalISIP)+temporalProperties.drainTimes;
% scatter(tiempo(iTimeFinalISIP-temporalProperties.drainTimes:end),pFEA(iTimeFinalISIP:end)*1e6/6894.76);
% title('Presion durante produccion')
% % ylabel('Presion FEA [Psi]')
% % % xlabel('tiempo [s]')
% minimo = min(pFEA(iTimeFinalISIP:end))*1e6/6894.76;
% maximo = max(pFEA(iTimeFinalISIP:end))*1e6/6894.76;
% ylim([minimo maximo])
% xlim([temporalProperties.tFinalISIP tiempo(end)])
% grid

