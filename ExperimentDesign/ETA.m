function value = ETA(IMFplan)
global critOpt
switch critOpt
    case 'D'
        % �������� D-�������������
        value = size(IMFplan,1);
    otherwise
        % �������� A-�������������. �� ���������
        value = trace(inv(IMFplan));
end
end