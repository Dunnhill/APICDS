function value = MU(alpha, IMFplan_value)
global critOpt
switch critOpt
    case 'D'
        % �������� D-�������������
        value = -trace(inv(IMFplan)*IMF(alpha));
    otherwise
        % �������� A-�������������. �� ���������
        value = -trace(inv(IMFplan_value)^2*IMF(alpha));
end
end