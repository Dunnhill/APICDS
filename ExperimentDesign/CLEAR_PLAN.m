function planClear = CLEAR_PLAN()
% ������� ������������� ��� ������� ������������ �����

global plan q
[nq,nr,nN] = size(plan.x);
planClear = struct ('x', [], 'p', []);
eps = 1e-3;
disp(plan.p);
for i=1:nq
    for k=1:nr
        use = false;
        
        % ���� ��� � ������ ����� ������� ���������
        if plan.p(i)<eps
            use = true;
            if i~=nq
                plan.p(i+1)=plan.p(i+1)+plan.p(i);
            else 
                plan.p(i-1)=plan.p(i-1)+plan.p(i);
            end
        end
        n = size(planClear.x,1);
        if use==false
            % �������� ����� � ��������� ����
            planClear.x(n+1,k,:)=plan.x(i,k,:);
            planClear.p(n+1)=plan.p(i);
        end
    end
% ������ ����� ����� �������
q = size(planClear.x,1); 
end
end