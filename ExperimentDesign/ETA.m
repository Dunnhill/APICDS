function value = ETA(IMFplan)
global critOpt
switch critOpt
    case 'D'
        % Критерий D-оптимальности
        value = size(IMFplan,1);
    otherwise
        % Критерий A-оптимальности. По умолчанию
        value = trace(inv(IMFplan));
end
end