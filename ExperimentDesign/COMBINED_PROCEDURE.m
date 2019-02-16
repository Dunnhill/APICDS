function COMBINED_PROCEDURE()
global plan minBorderU maxBorderU q r N
% Инициализация необходимых ограничений
lb(1:q,1:r,1:N)=minBorderU;
ub(1:q,1:r,1:N)=maxBorderU;
A(1:q,1:q)=-1; Aeq(1:q)=1; 
b(1:q)=0; beq=1;
% Прямая процедура для нахождения начального приближения
% Спуск по точкам спектра
plan.x = fmincon(@OPTIM_FUNC,plan.x,[],[],[],[],lb,ub,[],[],plan.p,'x');
% Спуск по весам
plan.p = fmincon(@OPTIM_FUNC,plan.p,A,b,Aeq,beq,[],[],[],[],plan.x,'p');
% Двойственная процедура для последовательного уточнения плана
DOUBLE_PROCEDURE();
end