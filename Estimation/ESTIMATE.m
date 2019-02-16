function ESTIMATE()
% Модуль предназначен для вычисления оценок неизвестных параметров c
% использованием критерия идентификации, основанного на методе
% максимального правдоподобия

global ptrue p0 lb ub p_est report
% Параметры для оптимизации
opts = optimset('Display','off','Algorithm','interior-point','GradObj','on');
tic;
% Оценивание
p_est = fmincon(@CRITERION,p0,[],[],[],[],lb,ub,[],opts);
stop = toc;
% Вывод информации в файл
fprintf('Полученные оценки:\n');
fprintf(report,'Полученные оценки:\r\n');
fprintf(report, '%.4f ',p_est);fprintf(report, '\r\n');
fprintf('Оценки найдены за %f секунд\n',stop);
fprintf(report,'Оценки найдены за %f секунд\n',stop);
% Вычисление относительной ошибки в пространстве параметров
RELATIVE_ERROR_THETA(p_est,ptrue);
% Графическое отображение результатов
DRAW_YMEAS_YEST();
end



