function F = F_FUNCTION(X,p,u,t)
% Функция вычисления правой части дифференциального уравнения модели
% состояний
% X - значение вектора состояний в котором вычисляется правая часть
% p - вектор параметров
% u - входной сигнал
global t0 r N

U=zeros(r);
for i=1:N
	if t >= t0(i) && t < t0(i+1)
        U=u(1,:,i);
        break;
	end
end
if U==zeros(r)
	U=u(1,:,N); 
end

F = zeros(4,1);
% Константы модели
m = 288674.58;
g = 9.8;
J22 = 44877565;
S = 510.97;
ro = 0.6536033;
c = 8.321;
Clde = 0.32;
Cmde = -1.3;
Cmq = -20.5;
mod_v = X(1)^2+X(2)^2; %||v||^2
q = 1/2*ro*mod_v;
alpha = atan(X(2)/X(1));

D=(p(1)+p(4)*alpha)*q*S;
L=(p(2)+p(5)*alpha+Clde*U(1))*q*S;
LA2=(p(3)+p(6)*alpha+Cmde*U(1)+Cmq*X(3)*c/(2*mod_v))*q*S*c;

F(1) = 1/m*(D-D*cos(alpha)+L*sin(alpha))-g*sin(X(4))-X(2)*X(3); 
F(2) = 1/m*(D-D*sin(alpha)-L*cos(alpha))+g*cos(X(4))+X(1)*X(3);
F(3) = 1/J22*LA2;
F(4) = X(3);
end