function result = PSI(M)
% ������� ��� ���������� �������� �������������
global critOpt
switch critOpt
    case 'D'
        % �������� D-�������������
        result = det(inv(M));
    otherwise
        % �������� A-�������������. �� ���������
        result = trace (inv(M));
end
end