function EXPERIMENT_DESIGN()
% модуль для построения оптимального входного сигнала на основе
% планирования эксперимента на основе комбинированной процедуры

% ПОДКЛЮЧИТЬ МОДУЛЬ С ВЫЧИСЛЕНИЕМ ИМФ
addpath(genpath('IMF'));
global N r q plan u t0 procedPlan
delimeter = '----------------------------------------------------------------';
% Инициализация
q=1;
plan = struct ('x', zeros(q,r,N), 'p', zeros(1,q));
optimal = true;
delta = 1e-3;
iter = 0;
% Начальный план
plan.x = CREATE_RANDOM_POINTS(q, r, N);
plan.p(1:q) = 1/q;
% Сохранение начального плана и значение целевой функции
planStart = struct ('x', plan.x, 'p', plan.p);
tic
% Поиск оптимального плана
% Запуск выбранной процедуры синтеза непрерывных планов
switch procedPlan
    case 'Прямая'
        DIRECT_PROCEDURE(); % Прямая процедура
    case 'Двойственная'
        DOUBLE_PROCEDURE(); % Двойственная процедура
    otherwise
        COMBINED_PROCEDURE(); % Комбинированная процедура. По умолчанию
end
stop = toc;
% Вывод в файл
out = fopen('ResultOfExperimentDesign.txt', 'w');
fprintf(out,'Начальный план\r\n'); PRINT_PLAN(planStart,out);
fprintf(out,'%s\r\nЗначение целевой функции для начального плана %f\r\n', delimeter,fvalStart);
fprintf(out,'%s\r\nРешение найдено\r\n', delimeter);
fprintf(out, 'Количество итераций: %i\n',iter);
fprintf(out,'%s\r\nПостроенный план\r\n', delimeter); PRINT_PLAN(plan,out);

% ИМФ полученного плана
M = IMF_PLAN(plan.x,plan.p);
% Проверка на оптимальность плана
causeNum=1;
for i=1:q
   diff = -MU(plan.x(i,:,:), M)-ETA(M);
   if  abs(diff)>delta
       optimal = false;
       cause(causeNum) = i;
       causeNum=causeNum+1;
   end
end
% ИМФ
fprintf(out, 'ИМФ:\r\n'); PRINT_MATRIX(M,out);
% Значение целевой функции
fprintf(out,'Значение целевой функции: %f\r\n',OPTIM_FUNC(plan.x,plan.p,'all'));
if optimal==true
    fprintf(out,'Необходимые и достаточные условия пройдены\r\n');
else
    fprintf(out,'Необходимые и достаточные условия не пройдены: \r\n');
    for i=1:length(cause)
        fprintf(out,'По причине %i точки \n',cause(i));
    end    
end

fprintf(out,'План построен за %f секунд\r\n',stop);
fclose(out);
% Округление 
ROUNDING(plan.p, 5);
% Присвоение входному сигналу точки полученного спектра
for i=1:q
   u(i,:,:)=plan.x(i,:,:);
   for j=1:r
       % Графическое отображения каждой точки спектра
        DRAW_INPUT(reshape(u(i,j,:),1,N),t0);
   end
end
end