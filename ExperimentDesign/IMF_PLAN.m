function [imf] = IMF_PLAN(x,p)
% ��������� ��� ���������� �������������� ������� �����

global s 
q=size(p);
imf = zeros(s);
for i=1:q
   imf = imf + p(i)*IMF(x(i,:,:)); 
end
end