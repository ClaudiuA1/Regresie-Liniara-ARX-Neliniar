
close all;
load('lab5_8.mat')
%u = [zeros(10, 1);1.4*rand(800,1); 0.2*ones(1000, 1)];

% plot(t,u,'g'),title("Semnal U");
% figure
% plot(t,vel),title("Semnal vel")
u=id.InputData;
vel = id.OutputData;
t=tid;

N=length(u);
ru=zeros(1,N);
ryu=zeros(1,N);

for tau=1:N
k=1:N-tau+1;
ru(tau)=1/N*sum(u(k+tau-1).*u(k));
ryu(tau)=1/N*sum(vel(k+tau-1).*u(k));
end

M=200;
inc=0;
RU=zeros(N,M);
for i=1:N
    for j=1:M
        RU(i,j)=ru(abs(j-i)+1);
    end
end

h=RU\ryu';
figure;
plot(h),title("H")

y_hat=conv(h,u);
plot(t,y_hat(1:length(t)))
hold on
plot(t,vel(1:length(t)),'r'), title("Semnal vel");

e=y_hat(1:length(t))-vel';
mse=1/length(e)*sum(e.^2);
fprintf("eroare medie patratica: %f\n",mse)

%%

u2=u(820:end);
vel2=vel(820:end);

y_hat=conv(h,u2);
y_hat=y_hat(1:length(vel2));
t2=t(1:length(y_hat));
figure
plot(t2,y_hat)
hold on
plot(t(1:length(vel2)),vel2,'r'), title("Semnal vel");

e=vel2-y_hat';
mse=1/length(e)*sum(e.^2);
fprintf("eroare medie patratica: %f\n",mse)


%%
clear
load('lab5_8.mat')

u_id = id.InputData;
y_id = id.OutputData;

u_val = val.InputData;
y_val = val.OutputData;

u_id=detrend(u_id);
y_id=detrend(y_id);

plot(detrend(id)), title('Identificare')

figure
plot(val), title('Validare')

% Identificare
Tau = 0:2499;
N = length(u_id); % lungimea semnalului

ru = zeros(1, length(Tau)); % initializam vectorul de autocorelatie
for t = 1 : length(Tau)-1
    suma = 0;
    tau = Tau(t);
    for k = 1 : (N - tau)
        suma = suma + u_id(k + tau) * u_id(k);
    end 
    ru(t) = 1 / N * suma;
end

ryu = zeros(1, length(Tau));
for t = 1 : length(Tau)-1
    suma = 0;
    tau = Tau(t);
    for k = 1 : (N - tau)
        suma = suma + y_id(k + tau) * u_id(k);
    end
    ryu(t) = 1 / N * suma;
end

% Matricea de regresie folosind valorile autocorelatie ru
M = 49; % lungimea modulului FIR
RU = zeros(N,M);

% Initializare cu valoarea ru(0) pe diagonala principala
%RU(1: M + 1 : end) = ru(1);

% Completare simetrica a matricei folosind valorile din autocorelatia ru
for i = 1:N
    for j = 1:M
        if i > j
            RU(i , j) = ru(abs(i - j) + 1);
        else
            %if i < j
                RU(i , j) = ru(abs(j - i) + 1);
            %end
        end
    end
end

h = RU \ ryu';

y_hat_id = conv(h, u_id);
y_hat_id = y_hat_id(1:length(y_id));

figure
plot(tid, y_id)
hold on
plot(tid, y_hat_id, 'r')
title('Aproximarea pentru identificare')
xlabel('uid'), ylabel('yid')

e_id = (y_id - y_hat_id) .^ 2;
mse_id = sum(e_id) / N;
%%
% Validare
N_val = length(u_val);
y_hat_val = conv(h, u_val);
y_hat_val = y_hat_val(1 : length(y_val));

figure 
plot(tval, y_val)
hold on
plot(tval, y_hat_val, 'g')
title('Aproximare pentru validare')
xlabel('uval'), ylabel('yval')

e_val = (y_val - y_hat_val) .^ 2;
mse_val = sum(e_val) / N_val

% figure
% plot(imp)
% hold on
% plot(h, 'g')

%%
%cod horicxa
clc;clear all;close all;
load('lab5_8.mat')
uid = id.InputData;
yid = id.OutputData;

uid = detrend(uid);
yid = detrend(yid);

plot(tid,uid);title("U id");
figure
plot(tid,yid);title("Y id");

N = length(uid);
ru = zeros(1,N);
ry = zeros(1,N);

for tau = 1:N-1
    sumau=0;
    sumay=0;
    for K = 1:(N - tau)
        sumau=sumau + uid(K+tau-1)*uid(K);
        sumay=sumay + yid(K+tau-1)*uid(K);
    end  
    ru(tau) = 1/N*sumau;
        ry(tau) = 1/N*sumay;
end

M=49;
RU = zeros(N,M);
for i = 1:N
    for j = 1:M
        if i - j>0
            RU(i,j) = ru(abs(j-i)+1);
        else
            RU(i,j) = ru(abs(i-j)+1);
        end
    end
end
h = RU\ry';
y_hat = conv(h,uid);
err = yid - y_hat(1:length(tid));
mse = 1/length(err)*sum(err.^2)

plot(tid,y_hat(1:length(tid)))
hold on
plot(tid,yid,'r')

%%

uval = val.InputData;
yval = val.OutputData;

uval = detrend(uval);
yval = detrend(yval);

figure
plot(tval,uval);title("U val");
figure
plot(tval,yval);title("Y val");
%%
N = length(uval);
ru = zeros(1,N);
ry = zeros(1,N);

for tau = 1:length(uval)
    for K = 1:(N - tau)
        sumau=uval(K+tau)*uval(K) +ru(tau);
        sumay=yval(K+tau)*uval(K)+ry(tau);
    end 
    ru(tau) = 1/N*(uval(K+tau)*uval(K) +ru(tau));
        ry(tau) = 1/N*(yval(K+tau)*uval(K)+ry(tau));
end

M = 50;
RU = zeros(N,M);
for i = 1:N
    for j = 1:M
        if i-j>0
            RU(i,j) = ru(abs(j-i)+1);
        else
            RU(i,j) = ru(abs(i-j)+1);
        end
    end
end
h = RU'/ry;
y_hat = conv(h,uval);
figure
plot(y_hat);
hold on
plot(yval);title("Y hat");
err = yval - y_hat(1:length(tval));
mse_val = 1/length(err)*sum(err.^2)


%%

for m = 1:250
%{
RU = zeros(N,m);
for i = 1:N
    for j = 1:m
        if i == j
            RU(i,j) = ru(1);
        else
            RU(i,j) = ru(abs(i-j));
        end
    end
end
%}
h = RU'/ry;
y_hat = conv(h,uid);
err = yid - y_hat(1:length(tid));
mse(m) = 1/length(err)*sum(err.^2);
end
figure
plot(y_hat,'r');
hold;
plot(yid,'b');
[M, I] = min(mse)
figure
plot(mse)
