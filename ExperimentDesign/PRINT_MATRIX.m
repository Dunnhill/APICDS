function PRINT_MATRIX(M,out)
% Функция предназначена для вывода матрицы M в файл с дескриптором out

s = length(M);
SpecFormat = '';
for i=1:s
   SpecFormat = strcat(SpecFormat,'%f','\t'); 
end
SpecFormat = strcat(SpecFormat,'\r\n');
fprintf(out,SpecFormat,M);

end