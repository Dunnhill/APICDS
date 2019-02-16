function deltaY = RELATIVE_ERROR_Y(Ymeas, Y)
% ������� ��������� ������������� ������ � ������������ ��������

global report

% ���������� ������� �������� ����� �������� � ��������� ��������
Y_=Ymeas-Y;
% ���������
numerator = sum(sum(Y_.^2));
% �����������
denominator = sum(sum(Ymeas.^2));
deltaY = sqrt(numerator/denominator);

fprintf('������������� ������ � ������������ ��������: %f\n',deltaY);
fprintf(report, '������������� ������ � ������������ ��������: %f\n',deltaY);

global m
error = zeros(1,m);
for i=1:m
    error(i) = norm(Y(:,i)-Ymeas(:,i))/norm(Ymeas(:,i));
end
fprintf('������������� ������ � ������������ �������� ��� ���������������: %f\n',mean(error));
fprintf(report, '������������� ������ � ������������ �������� ��� ���������������: %f\n',mean(error));
end