clear all;
close all;
load('lab4_order1_6.mat')
u1=data.U;
y1=data.Y;


k=y1/u1;
plot(t,u1,'r');legend('u','y');
hold on
plot(t,y1,'g');


ymax=0.28;
yss=0.12;
uss=0.5;
k=yss/uss;
x0=yss;
%%
yt=0.368*(ymax-yss)+yss;
T=5.4-3.72;

%[A, B, C, D]= tf2ss(k,[T 1]);
A=-1/T;
B=k/T;
C=1;
D=0;
sysmod=ss(A,B,C,D);

lsim(sysmod,u1,t,x0);
y_hat1=lsim(sysmod,u1,t,x0);
e1=y_hat1-y1;
mse1=1/length(e1)*sum(e1.^2);
fprintf("Eroare medie patratica la ordinul 1 este: %f\n", mse1)

t1=t(110:end);
u2id=u1(110:end);
y2id=y1(110:end);
figure;
hold on
plot(t1,u2id,'black')
plot(t1,y2id,'yellow')
lsim(sysmod,u2id,t1,x0);

%%
close all; clear all;
load('lab4_order2_1.mat');
y2=data.y;
u2=data.u;

plot(u2,'r')
hold on
plot(y2,'g'),legend('u','y');


yss=0.5;
uss=1;

k=yss/uss; 
t1=1.85;
t3=3.45;    
T0=t3-t1;

ymax=1.69;
ymin=0.18;
KM=ymax-yss;
KM2=yss-ymin;

Aplus=KM+yss;
Aminus=KM2;
M=Aminus/Aplus;

%%
yA1=y2(31:48);
yA2=y2(48:68);
A1=T0*sum(yA1-yss);
A2=T0*sum(yA2-yss);
M=abs(A2)/A1;
%%
tita=(-log(M))/(sqrt(pi^2+(log(M)^2)));
wn=(2*pi)/(T0*sqrt(1-tita^2));
y0=yss;

A=[0 1;-wn^2 -2*tita*wn];
B=[0; k*wn^2];
C=[1 0];
D=0;

H=ss(A,B,C,D);
lsim(H,u2,t,[y0 0]);title("Identificarea la gradul 2")

y_hat=lsim(H,u2,t,[y0 0]);
e=y2-y_hat;
mse=1/length(e)*sum(e.^2);
fprintf("Eroare medie patratica la gradul 2 este: %f\n", mse)

t2=t(130:end);
u2val=u2(130:end);
y2val=y2(130:end);
figure;
hold on
plot(t2,u2val,'yellow');
plot(t2,y2val,'black');
lsim(H,u2val,t2,[y0 0]);title("Validare la gradul 2");




