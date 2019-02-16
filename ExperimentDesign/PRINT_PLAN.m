function PRINT_PLAN(plan,out)
% ������� ������������� ��� ������ � ���� out ���� plan

[sq,sr,sN]=size(plan.x);
if (sq~=length(plan.p))
    fprintf(out,'����������� ������� ����� ������� �� ��������� � ������������ ������� �����\r\n');
else
    fprintf(out,'����� �������:\r\n');
    for k=1:sN
        for i=1:sq
            fprintf(out,'%f ', plan.x(i,k));
        end
        fprintf(out,'\r\n');
    end
    fprintf(out,'\r\n');
    fprintf(out,'����\r\n');
    for i=1:sq
        fprintf(out,'%f ', plan.p(i));
    end
    fprintf(out,'\r\n');
end
end