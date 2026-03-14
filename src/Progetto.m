warning off;
clear;
close all; 
equalautovalori = [1,1,1,1,1];
clusterautovalori = [100,101,102,103,104]; % clusterizzati
spaziautovalori = [1,10,100,1000,10000]; % spaziati


figure('Name','RISULTATI','WindowState','maximized');
tiledlayout(3,2);

maxrip = 8;
TestRunGrafici(equalautovalori, maxrip, 1,'Autovalori Uguali')
TestRunGrafici(clusterautovalori, maxrip, 2, 'Autovalori Clusterizzati')
TestRunGrafici(spaziautovalori, maxrip, 3, 'Autovalori Spaziati')
