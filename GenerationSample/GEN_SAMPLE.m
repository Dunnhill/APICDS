function GEN_SAMPLE()
% ������ ��� ��������� �������, ��������������� �������� ������������
 
global N tend R x0 q ki ptrue u m
global t0 Y

% ������������� ���������� � ����
Y=zeros(q,max(ki),N,m);
t0=0:tend/N:tend;

% ������������� ��� ������� �������
for i=1:q
       % ������ ���������������� ���������
        [T,X] = ode45(@(T,X)F_FUNCTION(X,ptrue,u(i,:,:),T), t0, x0);
        for j=1:ki(i)
            Y(i,j,:,:) = H_FUNCTION(X(2:N+1,:)) + mvnrnd(zeros(4,1),R,N);
        end        
end

% out = fopen('Y.txt', 'w');
% for i=1:q
%    for j=1:ki(i)
%       PRINT_MATRIX(reshape(Y(i,j,:,:),size(Y,3),size(Y,4)),out);
%       fprintf(out,'\r\n');
%    end
% end
% fclose(out);

% ����������� ����������� ����������
%DRAW_MEASUREMENTS();
end

