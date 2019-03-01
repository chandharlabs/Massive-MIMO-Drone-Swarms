clc;
clear all;
format long;

R = 1000; % radius of the sphere
NumSamples = 1000000; % number of samples
rvals = 2*rand(1,NumSamples)-1; 
el = asin(rvals)+pi/2; % elevation angle
az = 2*pi*rand(1,NumSamples); % azimuth angle
dist = R*(rand(1,NumSamples)).^(1/3); % distance

x = dist.*cos(az).*sin(el); % x coordinate
y = dist.*sin(az).*sin(el); % y coordinate
z = dist.*cos(el); % z coordinate

[a,b] = hist(el,1000);
figure(401);plot(b,a/sum(a)/(b(2)-b(1)));hold on;
th = 0:.01:pi; % elevation angle [0,pi]
f_th = sin(th)/2; % PDF of elevation angle
figure(401);plot(th,f_th,'r','linewidth',2);hold on;axis([0 pi 0 1]);
xlabel('Elevation angle (\theta)');ylabel('PDF: f_\Theta(\theta)');legend(2,'Simulation','Theory');

[a,b] = hist(az,1000);
figure(402);plot(b,a/sum(a)/(b(2)-b(1)));hold on;
ph = 0:.01:2*pi; % elevation angle [0,2*pi]
f_ph = 1/(2*pi); % PDF of azimuth angle
figure(402);plot(ph,f_ph,'r','linewidth',2);hold on;axis([0 6.20 0 .3]);
xlabel('Azimuth angle (\phi)');ylabel('PDF: f_\Phi(\phi)');legend(2,'Simulation','Theory');

[a,b] = hist(dist,1000);
figure(403);plot(b,a/sum(a)/(b(2)-b(1)));hold on;
r = 0:1:R; % distance [0,R]
f_r = 3*r.^2/R^3;  % PDF of distance
figure(403);plot(r,f_r,'r','linewidth',2);hold on;axis([]);
xlabel('Distance (r)');ylabel('PDF: f_D(r)');legend(2,'Simulation','Theory');

figure;plot3(x(1:1000),y(1:1000),z(1:1000),'.');box on;grid on;
