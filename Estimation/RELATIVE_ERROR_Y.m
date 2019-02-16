function deltaY = RELATIVE_ERROR_Y(Ymeas, Y)
% функция вычисляет относительную ошибку в пространстве откликов

global report

% вычисление вектора разности между откликом и оцененным откликом
Y_=Ymeas-Y;
% числитель
numerator = sum(sum(Y_.^2));
% знаменатель
denominator = sum(sum(Ymeas.^2));
deltaY = sqrt(numerator/denominator);

fprintf('Относительная ошибка в пространстве откликов: %f\n',deltaY);
fprintf(report, 'Относительная ошибка в пространстве откликов: %f\n',deltaY);

global m
error = zeros(1,m);
for i=1:m
    error(i) = norm(Y(:,i)-Ymeas(:,i))/norm(Ymeas(:,i));
end
fprintf('Относительная ошибка в пространстве откликов при масштабировании: %f\n',mean(error));
fprintf(report, 'Относительная ошибка в пространстве откликов при масштабировании: %f\n',mean(error));
end