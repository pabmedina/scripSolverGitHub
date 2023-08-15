
nCasos=6;

strain0=zeros(6,nCasos);

strain0(3,:) =-2e-3;

strain0(1:2,:)=[-6 -5 -4 -3 -2 -1.5;
                -1.5 -2 -3 -4 -5 -6].*10^-4;
            
for i=1:nCasos
     initialStrainExtS=strain0(:,i);
     nombreCorrida=['DFN_Angle_github_' num2str(i)];
     mainDfit_rev082023_variosInitialStrain
end