function [l,m,flag] = multalg(A,l0,toll,it,maxit)
% MULTALG Calcola molteplicità algebrica.
%   
%   Input:
%       A     - Matrice quadrata (reale o complessa) di cui si vogliono
%               calcolare le dimensioni dell'autospazio
%       l0    - Punto di partenza del metodo di Newton
%       toll  - Tolleranza per il test d'arresto dello scarto
%       it    - Intero maggiore o uguale a 2
%       maxit - Intero positivo maggiore di it
%   Output:
%       l     - Autovalore calcolato
%       m     - Naturale positivo, molteplicità
%       flag  - 1 per successo, 0 per errore
% 
    
    z=l0;
    step = 1;
    
    for i=1:it
        [~,g] = myobjective(z,A);
        z_new= z+g; % la g tiene già conto del segno meno
        prevstep = step;
        step = z_new - z;
        
        temp=abs(step/prevstep); 
        ms = round(1/(1-temp)); % m stimato   
          
        if abs(step)<toll
            % ho raggiunto la convergenza 
            l=z_new;
            % m=1; La traccia propone m=1 ma la teoria propone ms come
            % valore migliore.
            m = ms;
            flag=1;
            %disp(strcat('Tolleranza raggiunta, m = ',string(ms)));
            return;
        end
    z = z_new;
    end
    %disp('tolleranza non raggiunta, proseguo con Newton modificato');
    % faccio un guess per m usando gli ultimi due passi del metodo di Newton
    % e l'euristica |s_k+1|/|s_k| ≈ (m − 1)/m
    % temp=abs(step/prevstep); 
    % m = 1/(1-temp); % m stimato   
    % m = round(m); % Già calcolato
    m = max(1,ms); % evita problemi dovuti a stime iniziali errate (<0)
    l0 = z_new; % cambio il punto di partenza con il passo predecedente 
    for iter=1:10 %10 * maxit equivale a fare un ciclo 10 volte
        %disp(strcat('m = ',string(m),' iter = ',string(iter)));
        hist=nan(1,50); % Creo Array nullo per grafico
        z=l0;
        for i=1:maxit              % metodo di Newton modificato   
            [~,g]=myobjective(z,A);
            z_new= z + m*g;          % g tiene già conto del - 
            if abs(z_new-z)<toll
                l= z_new;
                flag=2;

                return;
            end

            % 
            % figure(2);
            % hist=[hist(2:end) z_new];% Mantengo solo gli ultimi 50 valori
            % plot([i-length(hist)+1:i],hist); % Come varia il passo: se converge al valore
            %                                  % o oscilla attorno ad esso a
            %                                  % causa del valore di m*g troppo
            %                                  % alto
            % title(strcat('Newton modificato con m = ',string(m),' iter ',string(iter)));
            % drawnow

            z=z_new;
        end
        m=m+1;
    end
    flag=0;
    l=z;
end
