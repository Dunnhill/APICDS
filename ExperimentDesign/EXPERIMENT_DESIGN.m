function EXPERIMENT_DESIGN()
% ������ ��� ���������� ������������ �������� ������� �� ������
% ������������ ������������ �� ������ ��������������� ���������

% ���������� ������ � ����������� ���
addpath(genpath('IMF'));
global N r q plan u t0 procedPlan
delimeter = '----------------------------------------------------------------';
% �������������
q=1;
plan = struct ('x', zeros(q,r,N), 'p', zeros(1,q));
optimal = true;
delta = 1e-3;
iter = 0;
% ��������� ����
plan.x = CREATE_RANDOM_POINTS(q, r, N);
plan.p(1:q) = 1/q;
% ���������� ���������� ����� � �������� ������� �������
planStart = struct ('x', plan.x, 'p', plan.p);
tic
% ����� ������������ �����
% ������ ��������� ��������� ������� ����������� ������
switch procedPlan
    case '������'
        DIRECT_PROCEDURE(); % ������ ���������
    case '������������'
        DOUBLE_PROCEDURE(); % ������������ ���������
    otherwise
        COMBINED_PROCEDURE(); % ��������������� ���������. �� ���������
end
stop = toc;
% ����� � ����
out = fopen('ResultOfExperimentDesign.txt', 'w');
fprintf(out,'��������� ����\r\n'); PRINT_PLAN(planStart,out);
fprintf(out,'%s\r\n�������� ������� ������� ��� ���������� ����� %f\r\n', delimeter,fvalStart);
fprintf(out,'%s\r\n������� �������\r\n', delimeter);
fprintf(out, '���������� ��������: %i\n',iter);
fprintf(out,'%s\r\n����������� ����\r\n', delimeter); PRINT_PLAN(plan,out);

% ��� ����������� �����
M = IMF_PLAN(plan.x,plan.p);
% �������� �� ������������� �����
causeNum=1;
for i=1:q
   diff = -MU(plan.x(i,:,:), M)-ETA(M);
   if  abs(diff)>delta
       optimal = false;
       cause(causeNum) = i;
       causeNum=causeNum+1;
   end
end
% ���
fprintf(out, '���:\r\n'); PRINT_MATRIX(M,out);
% �������� ������� �������
fprintf(out,'�������� ������� �������: %f\r\n',OPTIM_FUNC(plan.x,plan.p,'all'));
if optimal==true
    fprintf(out,'����������� � ����������� ������� ��������\r\n');
else
    fprintf(out,'����������� � ����������� ������� �� ��������: \r\n');
    for i=1:length(cause)
        fprintf(out,'�� ������� %i ����� \n',cause(i));
    end    
end

fprintf(out,'���� �������� �� %f ������\r\n',stop);
fclose(out);
% ���������� 
ROUNDING(plan.p, 5);
% ���������� �������� ������� ����� ����������� �������
for i=1:q
   u(i,:,:)=plan.x(i,:,:);
   for j=1:r
       % ����������� ����������� ������ ����� �������
        DRAW_INPUT(reshape(u(i,j,:),1,N),t0);
   end
end
end