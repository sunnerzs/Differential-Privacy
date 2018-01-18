%{
lambda = 1:0.25:4.5;
Opt_U=zeros(1,length(lambda));
Opt_epsilon_max = zeros(1,length(lambda));
for i=1:length(lambda)
    [ Opt_U(i),Opt_epsilon_max(i),~] = ProspectTheoryBased( lambda(i),0.88,0.88,10000,50,0.5,0.5,0,0.0001:0.0001:0.01 );
end

[ ~,Opt_epsilon_EUT_max,~] = ProspectTheoryBased( 1,1,1,10000,50,0.5,0.5,0,0.0001:0.0001:0.01 );

Uc_byEUT=zeros(1,length(lambda));
for i=1:length(lambda)
    [ Uc_byEUT(i),~,~] = ProspectTheoryBased( lambda(i),0.88,0.88,10000,50,0.5,0.5,0,Opt_epsilon_EUT_max);
end

plot(lambda,Opt_U,'*',lambda,Uc_byEUT,'o');
dif=Opt_U-Uc_byEUT;
per = dif./Opt_U*100
%}

%{
x=-0.25:0.001:0.25;
len = length(x);
y1 = zeros(1,len);
y2 = zeros(1,len);
y3 = zeros(1,len);
y4 = zeros(1,len);

for i=1:len
    y1(i)=Valuation_Fun( x(i),1,1,1,0);
end


hold on;
for i=1:len
    y2(i)=Valuation_Fun( x(i),1,1.5,1,0);
end

for i=1:len
    y3(i)=Valuation_Fun( x(i),0.8,1.5,0.8,0);
end

for i=1:len
    y4(i)=Valuation_Fun( x(i),0.5,2,0.5,0);
end

plot(x,y1,'k-',x,y2,'g:',x,y3,'-.',x,y4,'--','LineWidth',2)
legend('\lambda=1,\beta=1','\lambda=1.5,\beta=1','\lambda=1.5,\beta=0.8','\lambda=2,\beta=0.5')
set(gca,'XTick',0)
%}

%{
n_target1 = 2000; %data amount utility is 2/3 at this number
n_target2 = 4000;
n_target3 = 4000;

k1 = 0.989;
k2 = 0.989;
k3 = 0.509;
%k = 0.273;
%g = 0.271;
l1 = 9.8e-4;
l2 = 1.3e-4;
l3 = 1.3e-4;
%l1=(3*k1-1)/n_target1;
%l2=(3*k2-1)/n_target2;
%l3=(3*k3-1)/n_target3;
n = 1:6000;
len = length(n);
R1 = zeros(length(n),1);
R2 = zeros(length(n),1);
R3 = zeros(length(n),1);
for i = 1:len
    R1(i) = Rn(k1,l1,n(i));
    R2(i) = Rn(k2,l2,n(i));
    R3(i) = Rn(k3,l3,n(i));
end
plot(n,R1,'r-',n,R2,'k-.',n,R3,'b--','LineWidth',2)
xlabel('n');
ylabel('R(n)');
set(gca,'FontSize',15);
%}
%{
k1 = 1.959;
k2 = 0.709;
k3 = 1.09;
n = 1:10000;
len = length(n);
R1 = zeros(1,length(n));
R2 = zeros(1,length(n));
R3 = zeros(1,length(n));
for i = 1:len
    R1(i) = Rn(k1,l1,n(i));
    R2(i) = Rn(k2,l2,n(i));
    R3(i) = Rn(k3,l3,n(i));
end
%}
%plot(n,R1,'r',n,R2,'k',n,R3,'b')

%p = parpool(4);
%{
lambda = ones(1,100)*4.5;
epsilon1 = zeros(1,length(lambda));
U1 = zeros(1,length(lambda));
for i=1:length(lambda)
    [U1(i),epsilon1(i) ,~] = ProspectTheoryBased( lambda(i),1,1,5000,50,0,2,0,0.002:0.0001:0.02);
end
%plot(lambda,Opt_epsilon_max_1);
%U_mean = [U_mean mean(U1)]
mean(U1)
mean(epsilon1)
%}
%opt_eps_max_appro =[0.0132    0.0105    0.0084    0.0066    0.0062];
N=[5000 10000 20000 30000 40000];
opt_eps_max_appro = zeros(1,length(N));
opt_eps_max1 = zeros(1,length(N));
opt_eps_max2 = zeros(1,length(N));
opt_eps_max3 = zeros(1,length(N));
U_cmp = zeros(1,length(N));
for i=1:length(N)
    [ ~,opt_eps_max1(i),~] = ProspectTheoryBased( 2.25,1,1,N(i),1,0.5,0.5,0,0.001:0.0001:0.03 );
    [ ~,opt_eps_max2(i),~] = ProspectTheoryBased( 2.25,0.97,0.97,N(i),1,0.5,0.5,0,0.001:0.0001:0.03 );
    [ ~,opt_eps_max3(i),~] = ProspectTheoryBased( 2.25,0.88,0.88,N(i),1,0.5,0.5,0,0.001:0.0001:0.03 );
    [ opt_eps_max_appro(i) ] = Approximation_fun( 2.25,N(i),1,0.5,0.5 );
end
plot(N,opt_eps_max1,'*-',N,opt_eps_max2,'x-',N,opt_eps_max3,'^-',N,opt_eps_max_appro,'o-','LineWidth',2,'Markers',10);
%legend('Without approximation','With approximation');
%xlabel('N','FontSize',15);
%ylabel('optmal \epsilon^*','FontSize',15);
%set(gca,'FontSize',12);
%dif = opt_eps_max-opt_eps_max_appro;
%per = dif./opt_eps_max

%{
N=[5000 10000 20000 20000 40000 50000];
U_cmp = zeros(1,length(N));
for i=1:length(N)
    [ U_cmp(i),~,~] = ProspectTheoryBased( 2.25,1,1,N(i),1,0.5,0.5,0,opt_eps_max_appro(i));
    %[ opt_eps_max_appro(i) ] = Approximation(  2.25,N(i),1,0.5,0.5 );
end
%plot(N,opt_eps_max,'*',N,opt_eps_max_appro,'o');
U_dif = U-U_cmp;
per = U_dif./U
%}
%saveresult([Opt_epsilon_max_1,Opt_U_1],'E:\liao\MATLAB\Differential Privacy\Data\','data_1','.txt');


%for i=2:length(lambda)
%    [ Opt_U_2(i),Opt_epsilon_max_2(i),~] = ProspectTheoryBased( lambda(i),0.88,0.88,5000,1,0,2,0.005,0.002:0.0001:0.02 );
%end
%saveresult([Opt_epsilon_max_2,Opt_U_2],'E:\liao\MATLAB\Differential Privacy\Data\','data_2','.txt');
%{
Opt_U_3=zeros(6,1);
Opt_epsilon_max_3 = zeros(6,1);
for i=1:length(lambda)
    [ Opt_U_3(i),Opt_epsilon_max_3(i),~] = ProspectTheoryBased( lambda(i),0.88,0.88,5000,1,0,2,0.03,0.002:0.0001:0.025 );
end
saveresult([Opt_epsilon_max_3,Opt_U_3],'E:\liao\MATLAB\Differential Privacy\Data\','data_3','.txt');
%{
lambda = 1:0.5:4.5;
Opt_U_1=zeros(1,length(lambda));
Opt_epsilon_max_1 = zeros(1,length(lambda));
for i=1:length(lambda)
    [ Opt_U_1(i),Opt_epsilon_max_1(i),~] = ProspectTheoryBased( lambda(i),0.88,0.88,5000,1,0,2,0,0.002:0.0001:0.025 );
end
%}

[ ~,Opt_epsilon_EUT_max,~] = ProspectTheoryBased( 1,1,1,10000,50,0.5,0.5,0,0.0001:0.0001:0.01 );

Uc_byEUT=zeros(1,length(lambda));
for i=1:length(lambda)
    [ Uc_byEUT(i),~,~] = ProspectTheoryBased( lambda(i),0.88,0.88,10000,50,0.5,0.5,0,Opt_epsilon_EUT_max);
end

plot(lambda,Opt_U,'*',lambda,Uc_byEUT,'o');
dif=Opt_U-Uc_byEUT;
per = dif./Opt_U*100    
%}
%{
Opt_epsilon_max_1=[0.0236,0.0207,0.0185,0.0170,0.0160,0.0151];
%ProspectTheoryBased( lambda(i),0.88,0.88,5000,1,0,2,0.01,0.01:0.0001:0.02
%);lambda 1:0.5:3.5
Opt_epsilon_max_2=[0.0224,0.0203,0.0188,0.0176,0.0167,0.0161];
%ProspectTheoryBased( lambda(i),0.88,0.88,5000,1,0,2,0.04,0.02:0.0001:0.04 );lambda 1:0.5:3.5
Opt_epsilon_max_3=[0.0243,0.0243,0.0243,0.0243,0.0243,0.0243];
lambda = 1:0.5:3.5;
plot(lambda,Opt_epsilon_max_1,'b*-',lambda,Opt_epsilon_max_2,'ro-.',lambda,Opt_epsilon_max_3,'k^--','LineWidth',2);
xlabel('\lambda');
ylabel('Optimal \epsilon');
set(gca,'FontSize',15);
h = legend('\epsilon_{ref}=0','\epsilon_{ref}=0.01','\epsilon_{ref}=0.04')
set(h,'FontSize',20)

%}

%[U,epsilon ,~] = ProspectTheoryBased( 1,0.88,0.88,5000,1,0,2,0.02,0.002:0.0001:0.03)
