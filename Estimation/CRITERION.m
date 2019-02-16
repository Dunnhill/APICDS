function [Hi, gradHi] = CRITERION(p)
% Модуль для вычисления значения критерия идентификации, а также его
% градиента
% Входные параметры:
% p - вектор параметров
% Выходные параметры:
% Hi - значение критерия идентификации
% gradHi - значение градиента критерия

global t0 Y N x0 n q ki u s m 
[s1,s2,s3,s4] = size(Y);
% Определение ковариационной матрицы, ее производных и обратной
R_temp=RCALC(p);
DR=DR_DTHETA(p);
invR=inv(R_temp);
Hi = N*sum(ki)*log(det(R_temp));
% Инициализация для приращений
delta=0;
delta_grad = zeros(1,s);
gradHi = zeros(1,s);
for alpha = 1:s
   gradHi(alpha)=1/2*N*sum(ki)*trace(invR*reshape(DR(alpha,:,:),m,m));
end
% Вектор начальных условий для уравнений чувствительности
x0_sens = zeros(1,n*(s+1));
x0_sens(1:n)=x0;
opts = optimset('Display','off');
% Для каждого входного сигнала
for i=1:q
[T,Xi]=ode45(@(T,Xi)SENSITIVITY(Xi,p,u(i,:,:),T),t0,x0_sens,opts);
% Выделим вектор состояния
X=[];
for j=1:n
    X=[X,Xi(:,j)];
end
dX_dp=zeros(s,N+1,n);
% Производные вектора состояния по параметрам
for alpha=1:s
    dX_dp(alpha,:,:)=Xi(:,n+(alpha-1)*n:n+alpha*n-1); 
end
% Оцененный вектор отклика
Y_roof=H_FUNCTION(X);
for j=1:ki(i)
    for k=1:N
        % Вычисление критерия идентификации Hi
        % Вектор отклика в данный момент времени
        Y_temp = reshape(Y(i,j,:,:),s3,s4);
        temp=Y_temp(k,:)-Y_roof(k,:);
        delta = delta+temp*invR*temp';
        % Вычисление градиента критерия идентификации gradHi
        % Матрица Якоби
        dH = DH_DX(X(k+1,:));
        for alpha=1:s
            dy_dp=dH*reshape(dX_dp(alpha,k+1,:),1,n)';
            delta_grad(alpha)=delta_grad(alpha)+...
                     +dy_dp'*invR*temp'+...
                     +1/2*temp*invR*reshape(DR(alpha,:,:),m,m)*invR*temp';
        end
    end
end
end
Hi=1/2*(Hi+delta);
gradHi = gradHi - delta_grad;
end