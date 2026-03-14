function [] = TestRunGrafici(autovalori, maxrep, plotrow, description)
%TestRunGrafici Utilizza TestRun e crea i Grafici
%   Input:
%       autovalori:     array di autovalori
%       maxrep:         molteplicità massima
%       plotrow:        riga nella figure finale
%       description:    descrizione dati (e.g.'Clusterizzati','Uguali')

% Decido se usare plot o semilogx
disp(strcat("Inizio analisi per ",description));
autosort = sort(autovalori); 
if(autosort(1) == autosort(end))% se il primo e l'ultimo sono uguali uso plot
    logview = 0;
else
    delta = autosort(2:end)-autosort(1:end-1); % Mi calcolo tutte le distanze
    deltapos = delta(find(delta > 0)); % Tolgo le distanze uguali a zero
    if length(deltapos) < 2 % se sono tutti uguali o ho solo una distanza 
                            % diversa da zero non serve semilogx                   
        logview = 0;
    else
        % se la distanza minima è almeno 100 volte minore di quella massima
        % uso semilogx
        logview = (min(deltapos)/max(deltapos) < 0.01);
    end
end

rma = zeros(maxrep, length(autovalori));
rmg = zeros(maxrep , length(autovalori));
cmalg = zeros(maxrep , length(autovalori));
cmgeo = zeros(maxrep , length(autovalori));
clma = zeros(maxrep , length(autovalori));
flags = zeros(maxrep , length(autovalori));

for i=1:maxrep
    ripetizioni = i*ones([1 length(autovalori)]);
    [rma(i,:),rmg(i,:),cmalg(i,:),cmgeo(i,:),clma(i,:),flags(i,:)] = TestRun(autovalori,ripetizioni); 
end
disp('Elaborazione terminata');
disp(strcat("Autovalori non trovati: ",string(length(find(flags == 0)))));
disp(strcat("Autovalori trovati con Newton tradizionale: ",string(length(find(flags == 1)))));
disp(strcat("Autovalori trovati con Newton modificato: ",string(length(find(flags == 2)))));
figure(1);
if(logview)

    nexttile(2*(plotrow-1)+1);
    semilogx(autovalori,rmg, "-");
    hold on;
    semilogx(autovalori,cmgeo, "o");
    title(strcat(description, ' Molteplicità Geometrica'));
    
    nexttile;
    semilogx(autovalori,rma, "-");
    hold on;
    semilogx(autovalori,cmalg, "o");
    hold on
    for r=1:size(flags,1)
        bad = (find(flags(r,:) == 0));
        semilogx(autovalori(bad),cmalg(r,bad),"r*")
    end
    title(strcat(description, ' Molteplicità Algebrica'))
    drawnow;
else
    nexttile(2*(plotrow-1)+1);
    plot(autovalori,rmg, "-");
    hold on;
    plot(autovalori,cmgeo, "o");
    title(strcat(description, ' Molteplicità Geometrica'));
    
    nexttile;
    plot(autovalori,rma, "-");
    hold on;
    plot(autovalori,cmalg, "o");
    hold on
    for r=1:size(flags,1)
        bad = (find(flags(r,:) == 0));
        plot(autovalori(bad),cmalg(r,bad),"r*")
    end
    title(strcat(description, ' Molteplicità Algebrica'))
    drawnow;
end
end