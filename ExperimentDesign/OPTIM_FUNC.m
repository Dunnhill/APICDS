function res = OPTIM_FUNC(p1,p2,mode)
% функция предназначена для вычисления функционала от ИМФ
switch mode
    case 'p'
        M = IMF_PLAN(p2,p1); 
    otherwise
        M = IMF_PLAN(p1,p2);
end
res = PSI(M);        
end