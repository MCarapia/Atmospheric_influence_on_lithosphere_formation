% % This script plot the Figure 4 of the paper Atmospheric influence on 
% lithosphere formation during cooling of a global magma ocean.
% We use thermal diffusivity equation to model thermal cooling of the Earth 
% post giant impact. 
% This figure shows the solidification time of the crust as a function of 
% different values of the effective thermal conductivity for the atmosphere
% and the mantle. 

close all
clear all
clc


% (k convective)
K_Mantle =[100 500 1000 5000 10000 50000 100000];    % Effective thermal conductivity of mantle to represent convective heat flow W / m K
K_Atm =[100 500 1000 5000 10000 50000 100000];       % Effective thermal conductivity of atmosphere to represent convective heat flow W / m K

% Time calculated in million years
tMyrs=0:0.0001:10;

% This function create solidus and liquidus profiles
[Tsol, Tliq, Prof]=T_sol_liq;

% 
for i = 1:1:length(K_Mantle)
    for j = 1:1:length(K_Atm)

    % This function calculates the thermal evolution of the planet
[xkm, sol1]=Heat_diffusion_SPH_Lithos(1,K_Mantle(i),K_Atm(j));
    % This function calculates how long it takes for the surface to drop below 1400 K.
[T_S_1]=T_lithos(sol1(:,638));
T1(i,j)=T_S_1;

    % This function calculates the thermal evolution of the planet
[xkm, sol2]=Heat_diffusion_SPH_Lithos(2,K_Mantle(i),K_Atm(j));
    % This function calculates how long it takes for the surface to drop below 1400 K.
[T_S_2]=T_lithos(sol2(:,638));
T2(i,j)=T_S_2;


a=i
b=j
    end
end

for i = 1:1:length(K_Mantle)
    for j = 1:1:length(K_Atm)
        
        % This stores the solidification times of the surface.
        Times1(i,j)=tMyrs(T1(i,j));
        Times2(i,j)=tMyrs(T2(i,j));

    end 
end

f3=figure('color','white');
subplot(1,2,1)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s1=surf(K_Atm,K_Mantle,Times1,'FaceAlpha',0.75); colormap('jet');
c=colorbar; shading interp
c.Label.String = 'Years'; c.Label.FontSize = 16; 
c.Limits = [0 0.11];
c.Ticks = [0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11];
c.TickLabels = {'0','10,000','20,000','30,000','40,000','50,000','60,000','70,000','80,000','90,000','100,000','>100,000'};
s1.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log'; 
title('Maximum temperatures')

subplot(1,2,2)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s1=surf(K_Atm,K_Mantle,Times2,'FaceAlpha',0.75); colormap('jet');
c=colorbar; shading interp
c.Label.String = 'Myrs'; c.Label.FontSize = 16; 
c.Limits = [0 0.11];
c.Ticks = [0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11];
c.TickLabels = {'0','10,000','20,000','30,000','40,000','50,000','60,000','70,000','80,000','90,000','100,000','>100,000'};
s1.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log';
title('Minimum temperatures')




%
% Final note: The figures were adapted to the extension of the monitor 
% that was used at the time of creating them. So there may possibly be 
% some aesthetic mismatches in the figure.
%








