function PRINT_MATRIX(M,out)
% ������� ������������� ��� ������ ������� M � ���� � ������������ out

s = length(M);
SpecFormat = '';
for i=1:s
   SpecFormat = strcat(SpecFormat,'%f','\t'); 
end
SpecFormat = strcat(SpecFormat,'\r\n');
fprintf(out,SpecFormat,M);

end