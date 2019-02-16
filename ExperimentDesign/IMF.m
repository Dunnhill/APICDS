function M = IMF(u)
% Модуль предназначен для вычисления информационной матрицы Фишера
% Входные параметры:
% P - вектор параметров, относительно которого будет строиться ИМФ
% Выходные параметры:
% М - ИМФ

global N x0 n p_est s R t0 m

Rinv=inv(R);
%формирование начального вектора для системы уравений чувствительности
x0_sens = zeros(1,n*(s+1));
x0_sens(1:n)=x0;
% инициализация ИМФ
M=zeros(s,s);
% производные ковариационной матрицы по параметрам
DR=DR_DTHETA(p_est);
% найти производные dx_dtetai с помощью уравнений чувствительности
[T,SENS]=ode45(@(T,SENS)SENSITIVITY(SENS, p_est, u, T),t0,x0_sens);
X=SENS(:,1:n);
% вычисление ИМФ
for i=1:s
   for j=1:s
       dx_dtetai=SENS(:,n*i+1:n*(i+1));
       dx_dtetaj=SENS(:,n*j+1:n*(j+1));
       M(i,j)=N/2*trace(reshape(DR(i,:,:),m,m)*Rinv*reshape(DR(j,:,:),m,m)*Rinv);
       %цикл по элементам выборки (наблюдений)
       for k=1:N
            dh_dx=DH_DX(X(k+1,:));
            M(i,j)=M(i,j)+(dh_dx*dx_dtetai(k+1,:)')'*Rinv*dh_dx*dx_dtetaj(k+1,:)';
       end
   end    
end


end