function [Jordan,moltalg,moltgeo] = JordanMatrix(autovalori,ripetizioni)
%   JORDANMATRIX    Crea la matrice di Jordan e calcola molteplicità algebriche e
%                   geometriche
%
%   Input: 
%       autovalori  -   vettore degli autovalori
%       ripetizioni -   vettore conentenente le ripetizioni di ogni
%                       autovalore
%   Output:
%       Jordan      -   matrice di Jordan         
%       moltalg     -   molteplicità algebrica autovalori
%       moltgeo     -   molteplicità geometrica autovalori    
    
    % Creo Jordan vuota.
    Jordan = zeros(sum(ripetizioni,"all"));
    last = 0;

    for i=1:1:length(autovalori)
        % Creo il blocco di Jordan del i-esimo autovalore.
        blocco = autovalori(i)*eye(ripetizioni(i));
        for d=1:1:(ripetizioni(i)-1)
            blocco(d,d+1) = 1;
        end
        % Metto il blocco appena creato dentro alla Matrice di Jordan.
        r = ripetizioni(i);
        Jordan(last+1:last+r, last+1:last+r) = blocco;
        last = last + r;
    end
    
    % Mi calcolo molteplicità geometriche e algebriche per ogni autovalore.
    moltalg = zeros([1 length(autovalori)]);
    moltgeo = zeros([1 length(autovalori)]);
  
    for i=1:1:length(autovalori)
        F = find(autovalori == autovalori(i));
        moltalg(i) = sum(ripetizioni(F));
        moltgeo(i) = length(F);
    end
    
end