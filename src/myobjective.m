function [f,g] = myobjective(z,A)
%   Per ogni numero complesso z  restituisce f_a(z) e g_a(z)
B = A-z* eye(size(A));
[L,U,P] = lu(B);

%calcolo det P
s = 0; %contatore scambi
Q = P; %copio la matrice per effettuare gli scambi 
n=size(A,1);
for j= 1:n
    cerca1= find(Q(:,j) == 1);                      %cerco indice in cui si trova l'unico 1 della colonna j
    assert(length(cerca1) == 1, 'Errore Imprevisto (Aggiungi Tolleranza)' )
    if cerca1(1) ~= j                               % se non è in posizione j scambio le righe
       Q([j cerca1(1)], :) = Q([cerca1(1) j], :);   %scambio righe
       s = s+1;                                     %aumento contatore scambi
    end
end
det_P = (-1)^s;
det_U = prod(diag(U)); %determinante di U, tramite prodotti dei suoi elementi diagonali



f = det_U/det_P;
%calcolo inversa di B(z) usando fatt lu
X = U\(L\P);

% Calcolo diag dell inversa di B(z)
trace_invB = trace(X);
%calcolo di g_a(z)
g = 1/ trace_invB;

end