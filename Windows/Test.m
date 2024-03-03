N=300;
u=[zeros(50,1);idinput(N,'prbs',[],[-0.8 0.8]);zeros(100,1);0.4*ones(200,1)];

 [vel, alpha, t] = run(u, '6');
 plot(t, vel);
 figure
 plot(t,u)