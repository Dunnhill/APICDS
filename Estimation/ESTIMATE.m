function ESTIMATE()
% ������ ������������ ��� ���������� ������ ����������� ���������� c
% �������������� �������� �������������, ����������� �� ������
% ������������� �������������

global ptrue p0 lb ub p_est report
% ��������� ��� �����������
opts = optimset('Display','off','Algorithm','interior-point','GradObj','on');
tic;
% ����������
p_est = fmincon(@CRITERION,p0,[],[],[],[],lb,ub,[],opts);
stop = toc;
% ����� ���������� � ����
fprintf('���������� ������:\n');
fprintf(report,'���������� ������:\r\n');
fprintf(report, '%.4f ',p_est);fprintf(report, '\r\n');
fprintf('������ ������� �� %f ������\n',stop);
fprintf(report,'������ ������� �� %f ������\n',stop);
% ���������� ������������� ������ � ������������ ����������
RELATIVE_ERROR_THETA(p_est,ptrue);
% ����������� ����������� �����������
DRAW_YMEAS_YEST();
end



