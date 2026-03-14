function [rma,rmg,cma,cmg,clma,cfma] = TestRun(autovalori,molteplicita)
%TestRun Utilizza le funzioni per calcolare tutte le moltiplicità reali e
%stimate
%   
    range = max(abs(autovalori)); % range per creare la matrice random
    
    [J,rma,rmg] = JordanMatrix(autovalori,molteplicita); %creo Jordan
    
    n = size(J,1); % size == size Jordan
    B = -range + rand(n)*(abs(2*range)); %matrice base random per l'ortogonale
    
    [Q,~] = qr(B); % ottengo la matrice ortogonale
    
    A = (Q')*J*Q; % Creo A
    
    cmg = zeros([1 length(autovalori)]);% molteplicità geometriche calcolate da multgeo
    cma = zeros([1 length(autovalori)]);% molteplicità algebriche calcolate da multalg
    clma = zeros([1 length(autovalori)]);% autovalori calcolati da multalg
    cfma = zeros([1 length(autovalori)]);% flag calcolate da multalg
    toll = 1e-6; % o 1e-6
    
    for r=1:1:length(autovalori)       
        l0=autovalori(r)+rand(1);
        cmg(r) = multgeo(A,autovalori(r),toll);
        [clma(r), cma(r), cfma(r)] = multalg(A,l0,toll,5,500); 
        %se si aumenta il quarto valore aumenta la precisione della
        %molteplicità, se si aumenta il quinto valore aumenta il
        %quantitativo di flag = 1
    end
end