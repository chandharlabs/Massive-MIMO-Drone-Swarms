% Author: Prabhu Chandhar, Chandhar Research Labs, Chennai, India.


clc;
clear all;
format long;
f = 2.4e9; % Hz
c = 3e8; % m/s
lambda = c/f; % m
R = 1000;

K = 10;
for lp=1:K
rvals(lp,:)=2*rand(1,100000)-1;
el(lp,:)=asin(rvals(lp,:))+pi/2;    
az(lp,:)=2*pi*rand(1,100000);
radii(lp,:)=R*(rand(100000,1)).^(1/3);
% [x_j(lp).array,y_j(lp).array,z_j(lp).array] = sph2cart(az(lp,:),el(lp,:),radii);
x_j(lp).array = radii(lp,:).*cos(az(lp,:)).*sin(el(lp,:));
y_j(lp).array = radii(lp,:).*sin(az(lp,:)).*sin(el(lp,:));
z_j(lp).array = radii(lp,:).*cos(el(lp,:));
dk(lp,:) = sqrt(x_j(lp).array(1:end).^2+y_j(lp).array(1:end).^2+z_j(lp).array(1:end).^2);
z1(lp,:)= sin(el(lp,:)).*cos(az(lp,:));
end

del = .5*lambda;

lp_M=1;
for M = 10:10:100;[20:10:100 200:100:1000];[10:10:90 100:100:1000];
lp_d =1;

for lp =1:K-1
for lp_1=1:length(z1(lp,:))
    gk = exp(-i*2*pi*(dk(1,lp_1)+((1/2/dk(1,lp_1))*([1:M].^2*del^2))-(del*([1:M]-1)*z1(1,lp_1)))/lambda);
    gj = exp(-i*2*pi*(dk(lp+1,lp_1)+((1/2/dk(lp+1,lp_1))*([1:M].^2*del^2))-(del*([1:M]-1)*z1(lp+1,lp_1)))/lambda);
    y(lp,lp_1) = abs(gj*conj(gk).')^2;
end
end
U = sum(y)/M^2;
m1(lp_M) = mean(U); 
m2(lp_M) = mean(U.^2); 
m3(lp_M) = mean(U.^3); 
m4(lp_M) = mean(U.^4); 
lp_M=lp_M+1;
M
end


n=1;
for M=10:10:100
    M
a1 = (M^3*2/3)+(M/3);
a2 = M^2;
b1 = (M*(11*M^4+5*M^2+4))/20;
b2 = (M*M*(2*M^2+1))/3;
b3 = M^3;
c1 = (M*(151*M^6+70*M^4+49*M^2+45))/315;
c2 = (M*M*(11*M^4+5*M^2+4))/20;
c3 = ((M*(2*M^2+1))/3)^2;
c4 = M*M*M*(2*M^2+1)/3;
c5 = M^4;

meanU1(n)=(K-1)/M;
meanU2(n)=(((K-1)*a1)+(a2*(K-1)*(K-2)))/M^4;
meanU3(n)=(((K-1)*b1)+(3*(K-1)*(K-2)*b2)+((K-1)*(K-2)*(K-3)*b3))/M^6;
meanU4(n)=((c1*(K-1))+(c2*4*(K-1)*(K-2))+(c3*3*(K-1)*(K-2))+(c4*6*(K-1)*(K-2)*(K-3))+(c5*(K-1)*(K-2)*(K-3)*(K-4)))/M^8;
VarU(n)=meanU2(n)-(meanU1(n)^2);
sigU(n)=sqrt(VarU(n));
n = n+1;
end

figure(501);plot(10:10:100,m1,'b');hold on;plot(10:10:100,meanU1,'r');xlabel('M');xlabel('First moment of U');legend(2,'Simulation','Theory');
figure(502);plot(10:10:100,m2,'b');hold on;plot(10:10:100,meanU2,'r');xlabel('M');xlabel('Second moment of U');legend(2,'Simulation','Theory');
figure(503);plot(10:10:100,m3,'b');hold on;plot(10:10:100,meanU3,'r');xlabel('M');xlabel('Third moment of U');legend(2,'Simulation','Theory');
figure(504);plot(10:10:100,m4,'b');hold on;plot(10:10:100,meanU4,'r');xlabel('M');xlabel('Fourth moment of U');legend(2,'Simulation','Theory');
