function Error = RELATIVE_ERROR_THETA(thetaEst, thetaTrue)
% ������� ���������� ������������� ������ � ������������ ����������
% ������� ���������:
% thetaEst - ��������� �������� ����������
% thetaTrue - �������� �������� ����������
% �������� ���������:
% Error - �������� ������������� ������
global s report
if isempty(thetaTrue)
   fprintf('������������� ������ � ������������ ���������� �� ����� ���� ���������. ���������� �������� �������� ����������\n');
   fprintf(report, '������������� ������ � ������������ ���������� �� ����� ���� ���������. ���������� �������� �������� ����������\n');
else
    
    normTrue = norm(thetaTrue);
    normDelta = norm(thetaTrue-thetaEst);
    Error = normDelta/normTrue;
    fprintf('������������� ������ � ������������ ����������: %f\n', Error);
    fprintf(report, '������������� ������ � ������������ ����������: %f\n', Error);
    
     % ���������������    
    Error = 0; Errors1 = 0; Errors2 = 0; s1=0; s2=0;
    for i=1:s
       if thetaTrue(i)~=0
          Errors1 = Errors1 + abs(thetaEst(i) - thetaTrue(i))/abs(thetaTrue(i)); s1=s1+1;
       else 
          Errors2 = Errors2 + abs(thetaEst(i)); s2=s2+1; 
       end
    end
    if s1~=0
        Error = Error + 1/s1*Errors1;
    end
    if s2~=0
        Error = Error + 1/s2*Errors2;
    end
    fprintf('������������� ������ � ������������ ���������� ��� ���������������: %f\n', Error);
    fprintf(report, '������������� ������ � ������������ ���������� ��� ���������������: %f\n', Error);end

end