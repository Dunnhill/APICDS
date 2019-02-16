function DX = SENSITIVITY(X,p,u,t) 

%DX = F_FUNCTION(X,p,u,t);

global n s

% Константы модели
DX = zeros(n*(s+1),1);
DX(1:n) = F_FUNCTION(X,p,u,t);
fp = DF_DTHETA(X);
fx = DF_DX(X,p,u,t);
ind = n;
for i=1:s
    for k=1:n
        ind=ind+1;
        DX(ind)=fp(ind-n);
        for j=1:n
            DX(ind)=DX(ind)+fx((j-1)*n+j)*X(i*n+j);
        end
    end
end
    
end