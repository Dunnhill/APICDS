function ACTIVE_IDENTIFICATION()
% Головная функция для проведения активной параметрической идентификации
% непрерывно-дискретной системы

% Подключение модулей для генерации выборки, оценивания и планирования
addpath(genpath('GenerationSample'));
addpath(genpath('Estimation'));
addpath(genpath('ExperimentDesign'));
addpath(genpath('ModelSettings'));

global report
report = fopen('Report.txt','w');

fprintf('Считывание необходимой информации...\n');
INPUT_DATA();

fprintf('Считывание наблюдений...\n');
realData = READ_Y();
if realData==false
    fprintf('Генерация выборки наблюдений...\n');
    GEN_SAMPLE();
end


fprintf('Оценивание параметров...\n');
ESTIMATE();

fprintf('Планирование входных сигналов...\n');
EXPERIMENT_DESIGN();

fprintf('Пересчет оценок параметров...\n');
GEN_SAMPLE();
ESTIMATE();

fclose(report);
end

% function APICDS()
% % Головная функция для проведения активной параметрической идентификации
% % непрерывно-дискретной системы
% 
% % Подключение модулей для генерации выборки, оценивания и планирования
% % эксперимента
% addpath(genpath('GenerationSample'));
% addpath(genpath('Estimation'));
% addpath(genpath('ExperimentDesign'));
% addpath(genpath('ModelSettings'));
% 
% global report ptrue
% report = fopen('Report.txt','w');
% 
% % Считывание необходимой информации
% fprintf('Считывание необходимой информации...\n');
% INPUT_DATA();
% 
% % if isempty(ptrue)
% %     % Считывание имеющейся выборки наблюдений
% %     fprintf('Считывание наблюдений...\n');
% %     READ_Y();
% % else
% %     fprintf('Генерация выборки наблюдений...\n');
% %     GEN_SAMPLE();
% % end
% % 
% % % Оценивание параметров
% % fprintf('Оценивание параметров...\n');
% % ESTIMATE();
% % 
% % % Планирование входных сигналов
% % fprintf('Планирование входных сигналов...\n');
% % EXPERIMENT_DESIGN();
% 
% global p_est Y u t0 x0
% %xmean=zeros(1,6);
% ymeanest=zeros(size(Y,3),size(Y,4));
% ymeasmean=zeros(size(Y,3),size(Y,4));
% countRealizations = 5;
% % Пересчет оценок
% %fprintf('Пересчет оценок параметров...\n');
% for i=1:countRealizations
%     %INPUT_DATA();
%     u(1,1,:)=[0,-0.053,-0.053,-0.053,-0.053,-0.053,0,0,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053,0,0,0,-0.053,-0.053,0,0,0,0,0,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053,0,0,0,0,0,0,0,0,-0.053,-0.053,-0.053,0,0,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053 ];
%     %u(1,1,:)=[0.000000,-0.053000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,-0.053000,-0.053000,0.000000,-0.053000,0.000000,-0.053000,-0.053000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.053000,-0.053000,0.000000,-0.053000,0.000000,-0.053000,0.000000,0.000000,-0.053000,0.000000,-0.053000,0.000000,0.000000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,-0.053000,0.000000,-0.053000 ];
%     %p_est = [0.0175	0.2054	0.0013	0.1914	4.4325	-1.0111	0.037];
%     p_est = [0.0187	0.1715	0.0065	0.2285	4.2353	-0.8695];
%     GEN_SAMPLE();
%     %ESTIMATE();
%     % нахождение оцененного вектора отклика
%     [~,X] = ode45(@(T,X)F_FUNCTION(X,p_est,u(1,:,:),T), t0, x0);
%     Yest = H_FUNCTION(X);
%     % накапливание средних (оценки, оцененный отклик и наблюдение) 
%     %xmean=xmean+p_est;
%     ymeanest=ymeanest+Yest;
%     ymeasmean=ymeasmean+reshape(Y(1,1,:,:),size(ymeasmean,1),size(ymeasmean,2));
% end
% 
% %xmean=xmean/countRealizations;
% ymeanest=ymeanest/countRealizations;
% ymeasmean=ymeasmean/countRealizations;
% %fprintf('Полученные оценки после %i реализаций\n', countRealizations)
% %disp(xmean);
% %RELATIVE_ERROR_THETA(xmean,ptrue)
% DRAW(ymeasmean,ymeanest);
% fclose(report);
% end