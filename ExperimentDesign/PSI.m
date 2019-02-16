function result = PSI(M)
% Функция для вычисления критерия оптимальности
global critOpt
switch critOpt
    case 'D'
        % Критерий D-оптимальности
        result = det(inv(M));
    otherwise
        % Критерий A-оптимальности. По умолчанию
        result = trace (inv(M));
end
end