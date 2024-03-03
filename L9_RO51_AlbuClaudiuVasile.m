%clear;
clc;
close all;

load ('valori_lab6.mat')

 plot(vel);title("Vel")
 figure
 plot(u);title("Semnal U")

N=380;
u1=u(1:N);
vel1=vel(1:N);

u2=u(N+1:end);
vel2=vel(N+1:end);

t1=t(1:N);
t2=t(N:end);

na=5;
nb=5;
nk=1;

idata=iddata(vel1',u1,t1(2)-t1(1));
modelarx=arx(idata,[na nb nk]);

yhat=lsim(modelarx,u1);
%compare(modelarx,idata)



RUid = zeros(length(u1), na + nb);
nv=na*(na>=nb)+nb*(nb>na);
for i=1:length(u1)
    for j=1:nv
        
      %  RU(i,j)=-vel(abs(j-i)+1)*(i-j>=0)+0*(j<=Na);
      if (i-j>0)&&(j<=na)
            RUid(i,j)=-yhat(i-j);
        elseif(j<=na)
             RUid(i,j)=0;
      end
        
        if (i-j>0)&&(j<=nb)
            RUid(i,j+na)=u1(i-j);
        elseif(j<=nb)
             RUid(i,j+na)=0;
        end
    end
end

teta=RUid\yhat;
A(1)=1;
A(2:na+1)=teta(1:na);

B(1)=0;
B(2:nb+1)=teta(na+1:end);

ivmodel=idpoly(A,B,1,1,1,0,t1(2)-t1(1));

yhat2=lsim(ivmodel,u2);

figure
plot(yhat2)
hold on
plot(vel2)



