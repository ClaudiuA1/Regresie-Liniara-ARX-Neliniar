close all;

m=3;
x=ones(1,m);
if m==3
A=[1 0 1];
elseif m==4
   A=[1 0 0 1];
elseif m==5
   A=[0 1 0 0 1];
elseif m==6
   A=[1 0 0 0 0 1];
elseif m==7
   A=[1 0 0 0 0 0 1];
elseif m==8
   A=[1 1 0 0 0 0 1 1];
elseif m==9
   A=[0 0 0 1 0 0 0 0 1];
elseif m==10
   A=[0 0 1 0 0 0 0 0 0 1];
end

% for i =2:m  
% A(i,1:m)=1*(i==(1:m)+1);     
% end


% for i=2:100
%     x(i,1)=mod(A(1,:)*x(i-1,:)',2);
%     x(i,(2:m))=x(i-1,(2:m)-1);
% end

%(A(1,:)*x(i-1,:)')%2)

for i=2:100
x(i,1)=mod(A*x(i-1,:)',2);
x(i,2:m)=x(i-1,(2:m)-1);
end

plot(x(:,1))

SPAB3=x(:,1);

%%
close all;

m=10;
x=ones(1,m);
A=[];
if m==3
A=[1 0 1];
elseif m==4
   A=[1 0 0 1];
elseif m==5
   A=[0 1 0 0 1];
elseif m==6
   A=[1 0 0 0 0 1];
elseif m==7
   A=[1 0 0 0 0 0 1];
elseif m==8
   A=[1 1 0 0 0 0 1 1];
elseif m==9
   A=[0 0 0 1 0 0 0 0 1];
elseif m==10
   A=[0 0 1 0 0 0 0 0 0 1];
end

for i =2:m  
A(i,1:m)=1*(i==(1:m)+1);     
end


for i=2:100
    x(i,1)=mod(A(1,:)*x(i-1,:)',2);
    x(i,(2:m))=x(i-1,(2:m)-1);
end

plot(x(:,1))

SPAB10=x(:,1);

u=[zeros(1,30),(SPAB3*1.4-0.7)',zeros(1,99),(SPAB10*1.4-0.7)',zeros(1,99),0.4*ones(1,70)];

%%
close all;
load('datelab7.mat')

plot(u)
figure
plot(vel)

u3=u(1:150)';
u10=u(220:350)';
uvel=u(370:end)';

y3=vel(1:150)';
y10=vel(220:350)';
yvel=vel(370:end)';

%%
%SPAB3
data3=iddata(y3,u3,t(2)-t(1));
model3=arx(data3,[10 10 1]);
compare(data3,model3)

%%
%SPAB10
data10=iddata(y10,u10,t(2)-t(1));
model10=arx(data10,[10 10 1]);
compare(data10,model10)

%%
%final
dataval=iddata(yvel,uvel,t(2)-t(1));
compare(dataval,model10)
figure
compare(dataval,model3)




