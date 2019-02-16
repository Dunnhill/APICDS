function pnew = ROUNDING(p, v)
% Функция для округление непрерывного плана до дискретного
% Входные параметры: 
% p - вектор весов непрерывного плана
% v - число возможныз запусков системы
% Выходные параметры:
% pnew - вектор весов дискретного плана

global q ki
sigma1 = ceil((v-q)*p);
sigma2 = fix(v*p);
v1 = v-sum(sigma1);
v2 = v- sum(sigma2);
if v1 < v2
    sigma = sigma1; vv = v1;
else
    sigma = sigma2; vv = v2;
end
vp_sigma = v*p-sigma;
% расположим полученные значения в порядке убывания их значений
vp_sigma_des = sort(vp_sigma,'descend');
s= zeros(1,q);
for j=1:q
    for vv_ind=1:vv
       if vp_sigma(j)==vp_sigma_des(vv_ind)
           s(j)=1;
           break;
       end
    end
    
end
pnew = sigma+s;
for i =1:q
    fprintf('%i/%i\n',pnew(i),v);
end
ki=pnew;
end