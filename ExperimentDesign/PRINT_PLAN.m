function PRINT_PLAN(plan,out)
% функция предназначена для вывода в файл out план plan

[sq,sr,sN]=size(plan.x);
if (sq~=length(plan.p))
    fprintf(out,'Размерность вектора точек спектра не совпадает с размерностью вектора весов\r\n');
else
    fprintf(out,'Точки спектра:\r\n');
    for k=1:sN
        for i=1:sq
            fprintf(out,'%f ', plan.x(i,k));
        end
        fprintf(out,'\r\n');
    end
    fprintf(out,'\r\n');
    fprintf(out,'Веса\r\n');
    for i=1:sq
        fprintf(out,'%f ', plan.p(i));
    end
    fprintf(out,'\r\n');
end
end