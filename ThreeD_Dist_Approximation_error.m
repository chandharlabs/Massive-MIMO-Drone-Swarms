clc;
clear all;

f = 2.5e9; % carrier frequency in Hz
c = 3e8; % spped of light in m/s
lambda = c/f; % wavelength in m
Mx = 100; % Number of antenna elements along the x-axis
My = 1; % Number of antenna elements along the y-axis
delx = 1.5*lambda; % Element spacing along the x-axis
dely = 1.5*lambda; % Element spacing along the y-axis
R  = 25; % Distance between first antenna element and drone

z2=1;
for th = [0:pi/20:pi];pi/2; % Elevation angle
z1=1;
for ph = [0:pi/20:2*pi]; % Azimuth angle
for p = 1:Mx;
for q = 1:My;
l = (q-1)*My+p;
% Distance without higher order term
dist_without_ho(l) = R -(sin(th)*(((p-1)*delx*cos(ph))+((q-1)*dely*sin(ph))));
% Distance with higher order term
dist_with_ho(l) = R +((inv(2*R))*(((p-1)^2*delx^2)+ ((q-1)^2*dely^2)))-(sin(th)*(((p-1)*delx*cos(ph))+((q-1)*dely*sin(ph))));
% Exact distance
dist_exact(l) = R *sqrt(1+((inv(R^2))*(((p-1)^2*delx^2)+ ((q-1)^2*dely^2)))-(2*inv(R)*sin(th)*(((p-1)*delx*cos(ph))+((q-1)*dely*sin(ph)))));
end

end
error_without_ho(z2,z1) = (dist_exact(end)-dist_without_ho(end))*100./dist_exact(end); % Relative error without higher order term
error_with_ho(z2,z1) = (dist_exact(end)-dist_with_ho(end))*100./dist_exact(end); % Relative error with higher order term
z1=z1+1;

end
z2=z2+1;

end

figure;plot(dist_without_ho,'linewidth',2); hold on; plot(dist_with_ho,'g','linewidth',2);plot(dist_exact,'r--','linewidth',2);
xlabel('Antenna index');ylabel('Distance (m)');
legend(3,'without higher order term','with higher order term','exact','Location','northwest');
% axis([1 Mx 0 2*R]);

figure;mesh( [0:pi/20:2*pi]*180/pi,[0:pi/20:pi]*180/pi,abs(error_with_ho));
xlabel('Azimuth angle (deg)');ylabel('Elevation angle (deg)');zlabel('error (%) with higher order term');
axis([0 360 0 180 0 100]);colorbar;

figure;mesh( [0:pi/20:2*pi]*180/pi,[0:pi/20:pi]*180/pi,abs(error_without_ho));
xlabel('Azimuth angle (deg)');ylabel('Elevation angle (deg)');zlabel('error (%) without higher order term');
axis([0 360 0 180 0 100]);colorbar;
