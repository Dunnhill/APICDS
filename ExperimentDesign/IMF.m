function M = IMF(u)
% ������ ������������ ��� ���������� �������������� ������� ������
% ������� ���������:
% P - ������ ����������, ������������ �������� ����� ��������� ���
% �������� ���������:
% � - ���

global N x0 n p_est s R t0 m

Rinv=inv(R);
%������������ ���������� ������� ��� ������� �������� ����������������
x0_sens = zeros(1,n*(s+1));
x0_sens(1:n)=x0;
% ������������� ���
M=zeros(s,s);
% ����������� �������������� ������� �� ����������
DR=DR_DTHETA(p_est);
% ����� ����������� dx_dtetai � ������� ��������� ����������������
[T,SENS]=ode45(@(T,SENS)SENSITIVITY(SENS, p_est, u, T),t0,x0_sens);
X=SENS(:,1:n);
% ���������� ���
for i=1:s
   for j=1:s
       dx_dtetai=SENS(:,n*i+1:n*(i+1));
       dx_dtetaj=SENS(:,n*j+1:n*(j+1));
       M(i,j)=N/2*trace(reshape(DR(i,:,:),m,m)*Rinv*reshape(DR(j,:,:),m,m)*Rinv);
       %���� �� ��������� ������� (����������)
       for k=1:N
            dh_dx=DH_DX(X(k+1,:));
            M(i,j)=M(i,j)+(dh_dx*dx_dtetai(k+1,:)')'*Rinv*dh_dx*dx_dtetaj(k+1,:)';
       end
   end    
end


end