function ACTIVE_IDENTIFICATION()
% �������� ������� ��� ���������� �������� ��������������� �������������
% ����������-���������� �������

% ����������� ������� ��� ��������� �������, ���������� � ������������
addpath(genpath('GenerationSample'));
addpath(genpath('Estimation'));
addpath(genpath('ExperimentDesign'));
addpath(genpath('ModelSettings'));

global report
report = fopen('Report.txt','w');

fprintf('���������� ����������� ����������...\n');
INPUT_DATA();

fprintf('���������� ����������...\n');
realData = READ_Y();
if realData==false
    fprintf('��������� ������� ����������...\n');
    GEN_SAMPLE();
end


fprintf('���������� ����������...\n');
ESTIMATE();

fprintf('������������ ������� ��������...\n');
EXPERIMENT_DESIGN();

fprintf('�������� ������ ����������...\n');
GEN_SAMPLE();
ESTIMATE();

fclose(report);
end

% function APICDS()
% % �������� ������� ��� ���������� �������� ��������������� �������������
% % ����������-���������� �������
% 
% % ����������� ������� ��� ��������� �������, ���������� � ������������
% % ������������
% addpath(genpath('GenerationSample'));
% addpath(genpath('Estimation'));
% addpath(genpath('ExperimentDesign'));
% addpath(genpath('ModelSettings'));
% 
% global report ptrue
% report = fopen('Report.txt','w');
% 
% % ���������� ����������� ����������
% fprintf('���������� ����������� ����������...\n');
% INPUT_DATA();
% 
% % if isempty(ptrue)
% %     % ���������� ��������� ������� ����������
% %     fprintf('���������� ����������...\n');
% %     READ_Y();
% % else
% %     fprintf('��������� ������� ����������...\n');
% %     GEN_SAMPLE();
% % end
% % 
% % % ���������� ����������
% % fprintf('���������� ����������...\n');
% % ESTIMATE();
% % 
% % % ������������ ������� ��������
% % fprintf('������������ ������� ��������...\n');
% % EXPERIMENT_DESIGN();
% 
% global p_est Y u t0 x0
% %xmean=zeros(1,6);
% ymeanest=zeros(size(Y,3),size(Y,4));
% ymeasmean=zeros(size(Y,3),size(Y,4));
% countRealizations = 5;
% % �������� ������
% %fprintf('�������� ������ ����������...\n');
% for i=1:countRealizations
%     %INPUT_DATA();
%     u(1,1,:)=[0,-0.053,-0.053,-0.053,-0.053,-0.053,0,0,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053,0,0,0,-0.053,-0.053,0,0,0,0,0,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053,0,0,0,0,0,0,0,0,-0.053,-0.053,-0.053,0,0,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053,-0.053 ];
%     %u(1,1,:)=[0.000000,-0.053000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,-0.053000,-0.053000,0.000000,-0.053000,0.000000,-0.053000,-0.053000,0.000000,0.000000,0.000000,0.000000,0.000000,-0.053000,-0.053000,0.000000,-0.053000,0.000000,-0.053000,0.000000,0.000000,-0.053000,0.000000,-0.053000,0.000000,0.000000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,0.000000,-0.053000,-0.053000,-0.053000,0.000000,-0.053000,0.000000,-0.053000 ];
%     %p_est = [0.0175	0.2054	0.0013	0.1914	4.4325	-1.0111	0.037];
%     p_est = [0.0187	0.1715	0.0065	0.2285	4.2353	-0.8695];
%     GEN_SAMPLE();
%     %ESTIMATE();
%     % ���������� ���������� ������� �������
%     [~,X] = ode45(@(T,X)F_FUNCTION(X,p_est,u(1,:,:),T), t0, x0);
%     Yest = H_FUNCTION(X);
%     % ������������ ������� (������, ��������� ������ � ����������) 
%     %xmean=xmean+p_est;
%     ymeanest=ymeanest+Yest;
%     ymeasmean=ymeasmean+reshape(Y(1,1,:,:),size(ymeasmean,1),size(ymeasmean,2));
% end
% 
% %xmean=xmean/countRealizations;
% ymeanest=ymeanest/countRealizations;
% ymeasmean=ymeasmean/countRealizations;
% %fprintf('���������� ������ ����� %i ����������\n', countRealizations)
% %disp(xmean);
% %RELATIVE_ERROR_THETA(xmean,ptrue)
% DRAW(ymeasmean,ymeanest);
% fclose(report);
% end