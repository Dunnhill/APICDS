function value = MU(alpha, IMFplan_value)
global critOpt
switch critOpt
    case 'D'
        % Критерий D-оптимальности
        value = -trace(inv(IMFplan)*IMF(alpha));
    otherwise
        % Критерий A-оптимальности. По умолчанию
        value = -trace(inv(IMFplan_value)^2*IMF(alpha));
end
end