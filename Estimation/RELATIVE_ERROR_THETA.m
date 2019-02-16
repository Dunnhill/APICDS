function Error = RELATIVE_ERROR_THETA(thetaEst, thetaTrue)
% Функция вычисления относительной ошибки в пространстве параметров
% Входные параметры:
% thetaEst - оцененные значения параметров
% thetaTrue - истинные значения параметров
% Выходные параметры:
% Error - значение относительной ошибки
global s report
if isempty(thetaTrue)
   fprintf('Относительная ошибка в пространстве параметров не может быть вычислена. Неизвестны истинные значения параметров\n');
   fprintf(report, 'Относительная ошибка в пространстве параметров не может быть вычислена. Неизвестны истинные значения параметров\n');
else
    
    normTrue = norm(thetaTrue);
    normDelta = norm(thetaTrue-thetaEst);
    Error = normDelta/normTrue;
    fprintf('Относительная ошибка в пространстве параметров: %f\n', Error);
    fprintf(report, 'Относительная ошибка в пространстве параметров: %f\n', Error);
    
     % Масштабирование    
    Error = 0; Errors1 = 0; Errors2 = 0; s1=0; s2=0;
    for i=1:s
       if thetaTrue(i)~=0
          Errors1 = Errors1 + abs(thetaEst(i) - thetaTrue(i))/abs(thetaTrue(i)); s1=s1+1;
       else 
          Errors2 = Errors2 + abs(thetaEst(i)); s2=s2+1; 
       end
    end
    if s1~=0
        Error = Error + 1/s1*Errors1;
    end
    if s2~=0
        Error = Error + 1/s2*Errors2;
    end
    fprintf('Относительная ошибка в пространстве параметров при масштабировании: %f\n', Error);
    fprintf(report, 'Относительная ошибка в пространстве параметров при масштабировании: %f\n', Error);end

end