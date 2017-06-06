#Vissarion Konidaris
#Randomized Algotithms Course
# 19/3/2017

clc;
clear;
clc;

%%% Calculating the first bounds %%%
n1=[40:10:2000];
Chebyshev1=(1/4)*n1.^(-1/4);
delta_1=(1+2*n1.^(3/4))./(n1+1);
mean_1=(n1.^(3/4)).*((n1+1)./(2*n1));
Chernoff1=(exp(-delta_1)./((1-delta_1).^(1-delta_1))).^mean_1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Calculating the second bounds %%%
n2=[300:10:2000];
Chebyshev2=(1/4)*n2.^(-1/4);
delta_2=((1/2)*(n2.^(1/4))-2).^(-1);
mean_2=((1/2)*(n2.^(3/4)))-2*(n2.^(1/2));
Chernoff2=(exp(delta_2)./((1+delta_2).^(1+delta_2))).^mean_2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
subplot(2,1,1); 
plot(n1,Chebyshev1,'linewidth',2,n1,Chernoff1,'linewidth',2);
legend({'Chebyshev','Chernoff'},'location','northeast');
title('Plot of First Bounds');
xlabel('n');
ylabel('Probability of Error');

subplot(2,1,2); 
semilogy(n1,Chebyshev1,'linewidth',2,n1,Chernoff1,'linewidth',2);
legend({'Chebyshev','Chernoff'},'location','southwest');
title('Semilogy of First Bounds');
xlabel('n');
ylabel('Probability of Error');

figure(2);
subplot(2,1,1); 
plot(n2,Chebyshev2,'linewidth',2,n2,Chernoff2,'linewidth',2);
legend({'Chebyshev','Chernoff'},'location','northeast');
title('Plot of Second Bounds');
xlabel('n');
ylabel('Probability of Error');

subplot(2,1,2); 
semilogy(n2,Chebyshev2,'linewidth',2,n2,Chernoff2,'linewidth',2);
legend({'Chebyshev','Chernoff'},'location','southeast');
title('Semilogy of Second Bounds');
xlabel('n');
ylabel('Probability of Error');

