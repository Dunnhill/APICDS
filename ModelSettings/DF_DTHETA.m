function FP = DF_DTHETA(X)

m = 288674.58;
J22 = 44877565;
S = 510.97;
ro = 0.6536033;
c = 8.321;
mod_v = X(1)^2+X(2)^2; %||v||^2
q = 1/2*ro*mod_v;
alpha = atan(X(2)/X(1));
cosalpha = cos(alpha);
sinalpha = sin(alpha);
tmp3 = 1-cosalpha;
tmp8 = 1-sinalpha;
mqS = 1/m*q*S;

FP(1) =  mqS*tmp3;
FP(2) =  mqS*tmp8;
FP(3) =  0;
FP(4) =  0;
FP(5) =  mqS*sinalpha;
FP(6) =  -mqS*cosalpha;
FP(7) =  2;
FP(8) =  0;
FP(9) =  0;
FP(10) = 0;
FP(11) = 1/J22*q*S*c;
FP(12) = 0;
FP(13) = FP(1)*alpha;
FP(14) = FP(2)*alpha;
FP(15) = 0;
FP(16) = 0;
FP(17) = FP(5)*alpha;
FP(18) = FP(6)*alpha;
FP(19) = 0;
FP(20) = 0;
FP(21) = 0;
FP(22) = 0;
FP(23) = FP(11)*alpha;
FP(24) = 0;

end