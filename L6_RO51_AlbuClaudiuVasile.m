close all;clear;clc;

load ('valori_lab6.mat')

 plot(t,vel);title("Vel")
 figure
 plot(t,u);title("Semnal U")

N=370;
u1=u(1:N);
vel1=vel(1:N);

u2=u(N:end);
vel2=vel(N:end);

t1=t(1:N);
t2=t(N:end);

Na=7;
Nb=7;

RUid = zeros(length(u1), Na + Nb);
Nv=Na*(Na>=Nb)+Nb*(Nb>Na);
for i=1:length(u1)
    for j=1:Nv
        
      %  RU(i,j)=-vel(abs(j-i)+1)*(i-j>=0)+0*(j<=Na);
      if (i-j>0)&&(j<=Na)
            RUid(i,j)=-vel1(i-j);
        elseif(j<=Na)
             RUid(i,j)=0;
      end
        
        if (i-j>0)&&(j<=Nb)
            RUid(i,j+Na)=u1(i-j);
        elseif(j<=Nb)
             RUid(i,j+Na)=0;
        end
    end
end

% M=Na+Nb;
% 
% RU=[];
% for i=1:N
%     for j=1:Na
%         if i>j
%             RU(i,j)=-yid(i-j);
%         else
%             RU(i,j)=0;
%         end
%     end
% end
% 
% for i=1:N
%     for j=1:Nb
%         if i>j
%             RU(i,j+Na)=uid(i-j);
%         else
%             RU(i,j+Na)=0;
%         end
%     end
% end


RUval = zeros(length(u2), Na + Nb);
Nv=Na*(Na>=Nb)+Nb*(Nb>Na);
for i=1:length(u2)
    for j=1:Nv
      if (i-j>0)&&(j<=Na)
            RUval(i,j)=-vel2(i-j);
        elseif(j<=Na)
             RUval(i,j)=0;
      end
        
        if (i-j>0)&&(j<=Nb)
            RUval(i,j+Na)=u2(i-j);
        elseif(j<=Nb)
             RUval(i,j+Na)=0;
        end
    end
end

teta=RUid\vel1';
yhat=RUval*teta;

figure
plot(t2,vel2,'black');title("Yhat")
hold on
plot(t2,yhat,'r')
legend('vel2','yhat')


%% simulare
N=length(u2);
ysim=zeros(1,N);

% for k=1:N
%     for i=1:Nv
%         if (i<k)&&(i<=Na)        
%              ysim(k)=ysim(k)-teta(i)*ysim(k-i);    
%         end 
%         if ((i<k)&&(i<=Nb))
%              ysim(k)=ysim(k)+teta(i+Na)*u2(k-i);
%         end
%    end
% end
%%
for k=1:length(vel2)
    for i=1:Na
        if i<k
            ysim(k)=ysim(k)-ysim(k-i)*teta(i);
        end
    end
    for i=1:Nb
        if i<k
            ysim(k)=ysim(k)+u2(k-i)*teta(i+Nb);
        end
    end
end

for k=1:length(vel2)
    for j=1:Na
        if k>j
        RUval(k,j)=-vel2(k-j);
        else 
            RUval(k,j)=0;
        end
    end
end


for k=1:length(vel2)
    for j=1:Nb
        if k>j
        RUval(k,j+Nb)=u2(k-j);
        else 
            RUval(k,j+Nb)=0;
        end
    end
end

%%

figure
plot(t2,vel2);title("Ysim")
hold on
plot (t2,ysim)
legend('vel2','ysim')

e=vel2-ysim;
mse=1/length(e)*sum(e.^2);
fprintf("Eroare medie patratica este: %f \n",mse);


%%
% clc
% Nk=0;
% 
% Ts=ones(length(u));
% id=iddata(vel(1:370),u(1:370)',t(2)-t(1));
% %NN=struc(1:Na,1:Nb,1);
% %V=arxstruc(id,vel,N);
% model = arx(id, [Na Nb Nk]);
