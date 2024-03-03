clear
obj = DCMRun.start();

uval=[zeros(40,1);0.3*ones(70,1); zeros(40,1)];

uspab=[zeros(50,1);idinput(200,'prbs',[],[-0.8 0.8])];
%k=length(uval);
for k=1:length(uval)
    
yval(k) = obj.step(uval(k));
obj.wait();
end
na=3;
nb=3;
nk=1;
N=length(uspab);

%teta=zeros(na+nb,N);
P=1000*eye(na+nb);
teta_hat=zeros(na+nb,1);


phiid = zeros(na + nb);
nv=na*(na>=nb)+nb*(nb>na);
    for k=2:N
    yid(k)=obj.step(uspab(k));
    phiid=[];
        for j=1:nv
            
          %  RU(i,j)=-vel(abs(j-i)+1)*(i-j>=0)+0*(j<=Na);
          if (k-j>0)&&(j<=na)
                phiid(j)=-yid(k-j);
            elseif(j<=na)
                 phiid(j)=0;
          end
            
            if (k-j>0)&&(j<=nb)
                phiid(j+na)=uspab(k-j);
            elseif(j<=nb)
                 phiid(j+na)=0;
            end  
        end
phiid=phiid';
%eraore(1)=yid(1);
        eroare(k)=yid(k)-phiid'*teta_hat;
        P=P-(P*phiid*phiid'*P)/(1+phiid'*P*phiid);
        W=P*phiid;
        teta_hat=teta_hat+W*eroare(k);

        if( k==13)
            teta_procent=teta_hat(1:end);
        end
obj.wait();
    end
obj.stop();
A(1)=1;
B(1)=1;
A(2:na+1)=teta_hat(1:na)';
B(2:nb+1)=teta_hat(na+1:end)';

mod=idpoly([1 teta_hat(1:na)'],[1 teta_hat(na+1:end)'], [],[],[],0.01);
mod13=idpoly([1 teta_procent(1:na)'],[1 teta_procent(na+1:end)'],[],[],[],0.01);
validare=iddata(yval',uval,0.01);
compare(mod13,validare)

