function [k] = multgeo(A,l,toll)
% MULTGEO Calcola la dimensione dell'autospazio associato all'autovalore l.
%   k = multgeo(A, l, toll) restituisce k, il numero di elementi diagonali
%   della matrice U della fattorizzazione LU di (A - l*I) che, in modulo,
%   risultano essere inferiori alla soglia toll.
%
%   Input:
%       A    - Matrice quadrata (reale o complessa)
%       l    - Autovalore (scalare, reale o complesso)
%       toll - Tolleranza (scalare reale positivo) per la verifica della
%              condizione di "nullità" dei pivot di U
%
%   Output:
%       k    - Dimensione dell'autospazio (molteplicità geometrica)

    % Calcolo della matrice (A - l*I)
    M = A - l * eye(size(A));
    
    % Fattorizzazione LU della matrice M
    [~, U] = lu(M);
    
    % Estrazione degli elementi diagonali di U
    diagU = diag(U);
    
    % Conta degli elementi della diagonale di U il cui modulo è minore della soglia toll
    k = sum(abs(diagU) < toll);



end
