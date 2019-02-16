function FX = DF_DX(X,p,u,t)

global n t0 r N
U=zeros(r);
for i=1:N
	if t >= t0(i) && t < t0(i+1)
        U=u(1,:,i);
        break;
	end
end
if U==zeros(r)
	U=u(1,:,N); 
end

m = 288674.58;
g = 9.8;
J22 = 44877565;
S = 510.97;
ro = 0.6536033;
c = 8.321;
Clde = 0.32;
Cmde = -1.3;
Cmq = -20.5;
mod_v = X(1)^2+X(2)^2; %||v||^2
q = 1/2*ro*mod_v;
alpha = atan(X(2)/X(1));

Cd = p(1)+p(4)*alpha;
Cl = p(2)+p(5)*alpha+Clde*U(1);
Cm = p(3)+p(6)*alpha+Cmde*U(1)+Cmq*X(3)*c/(2*mod_v);

D=Cd*q*S;
L=Cl*q*S;

cosalpha = cos(alpha);
sinalpha = sin(alpha);

tmp=zeros(11,1);
FX=zeros(n*n,1);

tmp(1) = S*Cd*ro;
tmp(2) = S*q*p(4)/mod_v;
tmp(3) = 1-cosalpha;
tmp(4) = D/mod_v;
tmp(5) = S*Cl*ro;
tmp(6) = S*q*p(5)/mod_v;
tmp(7) = L/mod_v;
tmp(8) = 1-sinalpha;
tmp(9) = Cm*ro;
tmp(10) = p(6)*q/mod_v;
tmp(11) = Cmq*q*X(3)*c/(mod_v^2);

FX(1) =  1/m*((tmp(1)*X(1)-tmp(2)*X(2))*tmp(3)-tmp(4)*sinalpha*X(2)+(tmp(5)*X(1)-tmp(6)*X(2))*sinalpha-tmp(7)*cosalpha*X(2));
FX(2) =  1/m*((tmp(1)*X(2)+tmp(2)*X(1))*tmp(3)+tmp(4)*sinalpha*X(1)+(tmp(5)*X(2)+tmp(6)*X(1))*sinalpha+tmp(7)*cosalpha*X(1))-X(3);
FX(3) =  -X(2);
FX(4) =  -g*cos(X(4));
FX(5) =  1/m*((tmp(1)*X(1)-tmp(2)*X(2))*tmp(8)+tmp(4)*cosalpha*X(2)-(tmp(5)*X(1)-tmp(6)*X(2))*cosalpha-tmp(7)*sinalpha*X(2))+X(3);
FX(6) =  1/m*((tmp(1)*X(2)+tmp(2)*X(1))*tmp(8)-tmp(4)*cosalpha*X(1)-(tmp(5)*X(2)+tmp(6)*X(1))*cosalpha+tmp(7)*sinalpha*X(1));
FX(7) =  X(1);
FX(8) =  -g*sin(X(4));
FX(9) =  1/J22*S*c*(tmp(9)*X(1)-tmp(10)*X(2)-tmp(11)*X(1));
FX(10) = 1/J22*S*c*(tmp(9)*X(2)+tmp(10)*X(1)-tmp(11)*X(2));
FX(11) =  S*c*c*Cmq/(2*J22*mod_v);
FX(12)=0;
FX(13)=0;
FX(14)=0;
FX(15)=1;
FX(16)=0;

end