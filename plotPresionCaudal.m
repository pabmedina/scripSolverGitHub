%% Plots de Presion del nodo bomba & caudal de bomba vs tiempo.

indiceTiempo = temporalProperties.drainTimes+1:temporalProperties.nTimes;
tiempo = cumsum(temporalProperties.deltaTs(indiceTiempo));
%- Plot: Presion nodo bomba calculado por FEA.
pFEA = zeros(1,temporalProperties.nTimes);
for iTime = 1:temporalProperties.nTimes
    pTime           = dTimes(paramDiscEle.nDofTot_U+1:paramDiscEle.nDofTot_U+paramDiscEle.nDofTot_P,iTime)*temporalProperties.preCond;
    pFEA(iTime)     = pTime(bombaProperties.nodoBomba);    % Presion en el nodo Bomba calculada por FEA en cada iTime.
end

% Presion vs tiempo durante proceso de fractura.
figure
subplot(1,3,1)
iTimeInicioISIP = sum(tiempo<=temporalProperties.tInicioISIP)+temporalProperties.drainTimes;
scatter(tiempo(1:iTimeInicioISIP-temporalProperties.drainTimes),pFEA(temporalProperties.drainTimes+1:iTimeInicioISIP)*1e6/6894.76);
title('Presion y Q durante fractura')
ylabel('Presion FEA [Psi]')
% xlabel('tiempo [s]')
minimo = min(pFEA(temporalProperties.drainTimes+1:iTimeInicioISIP))*1e6/6894.76;
maximo = max(pFEA(temporalProperties.drainTimes+1:iTimeInicioISIP))*1e6/6894.76;
ylim([minimo maximo])
xlim([0 temporalProperties.tInicioISIP])
grid
yyaxis right
plot(tiempo(1:iTimeInicioISIP-temporalProperties.drainTimes),QTimes(bombaProperties.nodoBomba,temporalProperties.drainTimes+1:iTimeInicioISIP))


% Presion vs tiempo con bomba apagada.
subplot(1,3,2)
iTimeInicioISIP = sum(tiempo<=temporalProperties.tInicioISIP)+temporalProperties.drainTimes;
iTimeFinalISIP = sum(tiempo<=temporalProperties.tFinalISIP)+temporalProperties.drainTimes;
scatter(tiempo(iTimeInicioISIP-temporalProperties.drainTimes:iTimeFinalISIP-temporalProperties.drainTimes),pFEA(iTimeInicioISIP:iTimeFinalISIP)*1e6/6894.76);
title('Presion y Q con bomba apagada')
% ylabel('Presion FEA [Psi]')
xlabel('tiempo [s]')
minimo = min(pFEA(iTimeInicioISIP:iTimeFinalISIP))*1e6/6894.76;
maximo = max(pFEA(iTimeInicioISIP:iTimeFinalISIP))*1e6/6894.76;
ylim([minimo maximo])
xlim([temporalProperties.tInicioISIP, temporalProperties.tFinalISIP])
grid
yyaxis right
plot(tiempo(iTimeInicioISIP-temporalProperties.drainTimes:iTimeFinalISIP-temporalProperties.drainTimes),QTimes(bombaProperties.nodoBomba,iTimeInicioISIP:iTimeFinalISIP))


% Presion vs tiempo durante produccion.
subplot(1,3,3)
iTimeFinalISIP = sum(tiempo<=temporalProperties.tFinalISIP)+temporalProperties.drainTimes;
scatter(tiempo(iTimeFinalISIP-temporalProperties.drainTimes:end),pFEA(iTimeFinalISIP:end)*1e6/6894.76);
title('Presion y Q durante produccion')
% ylabel('Presion FEA [Psi]')
% xlabel('tiempo [s]')
minimo = min(pFEA(iTimeFinalISIP:end))*1e6/6894.76;
maximo = max(pFEA(iTimeFinalISIP:end))*1e6/6894.76;
ylim([minimo maximo])
xlim([temporalProperties.tFinalISIP tiempo(end)])
grid
yyaxis right
plot(tiempo(iTimeFinalISIP-temporalProperties.drainTimes:end),QTimes(bombaProperties.nodoBomba,iTimeFinalISIP:end))
ylim([QTimes(bombaProperties.nodoBomba,end)*1.1 0])
ylabel('Q [BPM] ')
