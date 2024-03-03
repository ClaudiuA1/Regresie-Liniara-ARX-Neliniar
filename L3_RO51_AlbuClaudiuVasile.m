clear all;
close all;
load('lab3_order1_3.mat')
u1=data.U;
y1=data.Y;

k=y1/u1;
hold on
plot(t,u1,'r')
plot(t,y1,'g')

yss1=9;
uss1=3;
k=yss1/uss1;
yT=yss1*0.632;
T=2.95;% de pe grafic de la punctul yT
fprintf("Factorul de proportionalitate K=%f, constanta de timp T=%f\n",k,T)

figure;
H=tf(k,[T 1]);

lsim(H,u1,t)

yhat1=lsim(H,u1,t);

e=yhat1-y1;
mse=1/length(e)*sum(e.^2);
hold off
fprintf("Eroare medie patratica este: %f\n",mse)


%%
clear all;
close all;
load('lab3_order2_5.mat')
u2=data.U;
y2=data.Y;

k2=y2/u2;
hold on
plot(t,u2,'r')
plot(t,y2,'g')
%plot(t,k2,'black')

yss2=1;
uss2=0.5;
yt1=1.58;
T2=2.27-0.78;

k2=yss2/uss2;
M=(yt1-yss2)/yss2;
tita=(-log(M))/(sqrt(pi^2+(log(M)^2)));
wn=(2*pi)/(T2*sqrt(1-tita^2));

H2=tf(k2*wn^2,[1 2*tita*wn wn^2]);
lsim(H2,u2,t)
fprintf("Suprareglajul M= %f si perioada deoscilatie T=%f\n",M,T2)
yhat2=lsim(H2,u2,t);
e2=yhat2-y2;
mse2=1/length(e2)*sum(e2.^2);
hold off
fprintf("Eroare medie patratica este: %f\n",mse2)

t1=t(200:end);
u2val=u2(200:end);
y2val=y2(200:end);
figure;
hold on
plot(t1,u2val,'yellow');title("Validare");
plot(t1,y2val,'black');
lsim(H2,u2val,t1)

