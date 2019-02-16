function DRAW_MEASUREMENTS()
% Функция графического отображения полученных наблюдений.
% Для одного входного сигнала все реализации усредняются.
global Y t0
[s1,s2,s3,s4] = size(Y);
YALL = zeros(s3,s4);
% Нахождение средней реализации для i-того сигнала
for i=1:s1
    % усреднение по всем реализациям
    for j=1:s2
      YALL=YALL+reshape(Y(i,j,:,:),s3,s4); 
    end
    YALL=YALL/s2;
    % новое окно
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    numcol = ceil(s4/2);
    numrow = 2;
    for k=1:s4
        subplot(numrow,numcol,k);
        plot(t0,YALL(:,k));
        xlabel('time (sec)');
        ylabel(strcat('Y',num2str(k)));
    end
end
end