close all;
clear
clc
load('lab8_date.mat')

plot(u)
figure
plot(vel)

f=0.1;
b=200;
nk=2;

u_id=u(1:399);
u_val=u(399:end);

y_id=vel(1:399);
y_val=vel(399:end);

N=length(y_id);

lmax=1000;
l=1;
alpha=0.1;
delta=10e-5;
theta=[b,f]';

%%
dv=0;
hess=0;

while l<=lmax
    f=theta(2,l);
    b=theta(1,l);
    e=zeros(1,N);
    e(1:nk)=y_id(1:nk);
    de=zeros(2,nk);

    for k=1+nk:N
        e(k)=y_id(k)+f*y_id(k-1)-b*u_id(k-nk)-f*e(k-1);
        de(1,k)=-f*de(1,k-1)-u_id(k-nk);
        de(2,k)=-e(k-1)-f*de(2,k-1)+y_id(k-1);
        
    end
  for a = 1:N
      dv=dv+e(a)*de(:,a);
      hess=hess+de(:,a)*de(:,a)';
  end
dv=(2/(N-nk))*dv;
hess=(2/(N-nk))*hess;
theta(:,l+1)=theta(:,l)-alpha*(hess\dv);
l=l+1;
    if (norm(theta(:,l-1)-theta(:,l))<=delta)
        break;
    end
    %theta1 = theta2;
end
f=theta(2,l);
b=theta(1,l);
idata=iddata(y_val',u_val,t(2)-t(1));

model=idpoly(1,[0 0 b],1,1,[1 f],0,t(2)-t(1));

compare(model,idata)



