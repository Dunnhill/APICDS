function DOUBLE_PROCEDURE()
global r N plan alphak minBorderU maxBorderU
% Инициализация необходимых ограничений
lb_alpha(1,1:r,1:N)=minBorderU;
ub_alpha(1,1:r,1:N)=maxBorderU;
% Настройки процедуры
iter = 0; exit = false; maxiter = 100;
% Настройка локального решателя
opts = optimset('Algorithm','sqp','Display','final');
while exit == false && iter < maxiter
    iter=iter+1;  
    IMFplan_value = IMF_PLAN(plan.x,plan.p);
    ex=false;
    while ex==false
        % Шаг 2 двойственной процедуры
        startAlpha=CREATE_RANDOM_POINTS(1,1,N);
        [alphak,fvalAlpha] = fmincon(@MU,startAlpha,[],[],[],[],lb_alpha,ub_alpha,[],opts,IMFplan_value);
        EtaM = ETA(IMF_PLAN(plan.x,plan.p));
        if abs(-fvalAlpha - EtaM)<=delta
            exit = true;
        end
        if -fvalAlpha > EtaM
            % Шаг 3
            tauk=fmincon(@PSI_TAU,1,[],[],[],[],0,1,[]);
            % Шаг 4
            plan.x=[plan.x; alphak];
            plan.p=[(1-tauk)*plan.p, tauk];
            plan = CLEAR_PLAN();
            ex=true;
        end
    end        
end
end