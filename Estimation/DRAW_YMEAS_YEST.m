function DRAW_YMEAS_YEST()

global Y t0 u x0 p_est N
[s1,s2,s3,s4] = size(Y);
Ymeas = zeros(s3,s4);
% Нахождение средней реализации для i-того сигнала
for i=1:s1
    % Вычисление оцененного вектора отклика
    [T,X] = ode45(@(T,X)F_FUNCTION(X,p_est,u(i,:,:),T), t0, x0);
    Yest = H_FUNCTION(X(2:N+1,:));
    % Усреднение по всем реализациям
    for j=1:s2
      Ymeas=Ymeas+reshape(Y(i,j,:,:),s3,s4); 
    end
    Ymeas=Ymeas/s2;
    % Новое окно
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    numcol = ceil(s4/2);
    numrow = 2;
    % Для каждой компоненты вектора отклика
    for k=1:s4
        subplot(numrow,numcol,k);
        hold on
        plot(t0(2:N+1),Ymeas(:,k),'-rs','MarkerFaceColor','r');
        plot(t0(2:N+1),Yest(:,k),'-bo','MarkerFaceColor','b');
        xlabel('time (sec)');
        ylabel(strcat('Y',num2str(k)));
        hold off
        grid on
        legend('Наблюдение','Оцененный отклик',-1);
        
    end
    % Вычисление относительных ошибок в пространстве откликов
    RELATIVE_ERROR_Y(Ymeas,Yest);
end
end