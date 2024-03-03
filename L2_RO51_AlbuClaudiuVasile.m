close all;
load('lab2_07.mat');
xi=id.X;
yi=id.Y;
xv=val.X;
yv=val.Y;

N=30;
V = zeros(1,N);
V_val = zeros(1,N);

for n=1:N
y=zeros(length(xi),n);
for i=1:length(xi)
    for j=1:n
    y(i,j)=xi(i).^(j-1);
    end
end
theta=y\yi';
y_hat=y*theta;
e=yi'-y_hat;
V(n)=1/length(e)*sum(e.^2);

y_val=zeros(length(xv),n);
for i=1:length(xv)
    for j=1:n
    y_val(i,j)=xv(i).^(j-1);
    end
end

y_hat_val=y_val*theta;
e_val=yv'-y_hat_val;
V_val(n)=1/length(e_val)*sum(e_val.^2);
end



[minim,index_min]=min(V_val);
fprintf("Eroare minima (%f) este la polinomul de gradul: %d\n",minim,index_min);
%%
for i=1:length(xi)
y(i,1:N)=xi(i).^((1:N)-1);    
end
%%
close all;
figure;

plot(yi);title('Y la Id');
hold on
plot(y_hat);
hold off
figure
plot(yv);title('Y la validare');
hold on
plot(y_hat_val);
hold off

figure
% subplot(211)
% plot(e); title('Eroarea la Id');
% subplot(212)
plot(e_val);title('Eroarea la validare');

% figure
% subplot(211)
% plot(V); title('Eroare mmedie patratica la validare(MSE) la Id');
% subplot(212)
plot(V_val); title('Eroare medie patratica(MSE) la validare');

figure
plot(y_hat_val(index_min:n));title('y')
hold on
plot(yv(index_min:n))
