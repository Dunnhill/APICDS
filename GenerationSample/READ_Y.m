function success = READ_Y()

global Y q ki m N
success=true;
in = fopen('Y.txt','r');
if in==-1
    success=false;
else
for i=1:q
   for j=1:ki(i)
      [Y_,count]=fscanf(in,'%g',[N,m]);
      if count~=N*m
          success=false; break;
      end
      Y(i,j,:,:)=reshape(Y_,1,1,N,m);
   end
end
end
end