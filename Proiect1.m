





















%%
close all;
load('proj_fit_10.mat');

m=3;
N=id.dims;
X1=id.X{1};
X2=id.X{2};
Y=id.Y;

figure;
mesh(Y);

phi=zeros(N(1),m);

for i=1:N
v=0;
w=0;
    %for k=1:m
        for j=1:m+1
             phi(i,j)=X1(i)^(j-1);
             phi(i,j+m)=X2(i)^(j-1);
            phi(i,m*2+j)=X1(i)^(v-w)*X2(i)^(j-v);
            % phi(i,j)*phi(i,j+m+v);
            if (v<m-1)
            v=v+1;
            else
                w=w+1;
            end
        end
   % end
%     phi(i,m*2+1+j)=X1(i)^j*X2(i)^i;
end
teta=phi\Y';
y_hat=phi*teta;
figure
mesh(y_hat);



