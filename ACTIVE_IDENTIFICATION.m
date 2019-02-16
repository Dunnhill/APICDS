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
