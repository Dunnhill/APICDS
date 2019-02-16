function x = CREATE_RANDOM_POINTS(q, r, N)
% ������� ��� �������� ��������� ����� ������� ��� �����������

global minBorderU maxBorderU
x = zeros(q,r,N);
for i=1:q
    for j=1:r
        for tk =1:N
        randomNumber = rand;
        if(randomNumber < 0.5) 
            x(i,j,tk) = minBorderU;
        else 
            x(i,j,tk) = maxBorderU;
        end
        end
    end
end

end