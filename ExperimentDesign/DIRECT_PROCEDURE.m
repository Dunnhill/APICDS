function DIRECT_PROCEDURE()
global q r N plan minBorderU maxBorderU
% ������������� ����������� �����������
lb(1:q,1:r,1:N)=minBorderU;
ub(1:q,1:r,1:N)=maxBorderU;
A(1:q,1:q)=-1; Aeq(1:q)=1; 
b(1:q)=0; beq=1;
% ��������� ���������
iter = 0; exit = false; eps = 1e-5; maxiter = 100;
% ��������� ���������� ��������
opts = optimset('Algorithm','sqp','Display','final');
% ��������� ������ ������ ����������� ��������
gs = GlobalSearch('NumTrialPoints',500);
while exit == false && iter < maxiter
    iter=iter+1; 
    % ���������� ���� �� ���������� ��������
    x_old = plan.x; p_old = plan.p;
    % ���������� ����� �� ������ �������
    problemX = createOptimProblem ('fmincon', 'x0',plan.x, ...
                                   'objective', @OPTIM_FUNC, 'lb', lb, ...
                                   'ub', ub, 'options', opts);
    plan.x = run(gs,problemX); 
    % ����� �� �����
    plan.p = fmincon(@OPTIM_FUNC,plan.p,A,b,Aeq,beq,[],[],[],opts,plan.x,'p');
    % �������� �� ����� (��� 4)
    out = sqrt(sum(sum(sum((plan.x-x_old).^2))));
    out = out + sum((plan.p-p_old).^2);
    if out < eps
       exit = true; 
    end 
end
end