% % This script plot the Figure 2 of the paper Atmospheric influence on 
% lithosphere formation during cooling of a global magma ocean. 
% We use thermal diffusivity equation to model thermal cooling of the Earth 
% post giant impact. This figure shows four extreme scenarios for the 
% initial conditions of maximum temperatures.

close all
clear all
clc
 

% This use maximum temperature envelope
InitialT=1;

% Thermal properties
rho=3500;                       % Density in kg/m3
Cp=1000;                        % Heat capacity in J/(kg K)
rho_Atm=1;                      % Density in kg/m3
Cp_atm=2000;                    % Heat capacity in J/(kg K)
K_Mantle =[1e2 1e3 1e4 1e5];    % k convective of mantle to represent convective heat flow 
K_Atm =[1e2 1e3 1e4 1e5];       % k convective of atmosphere to represent convective heat flow 

% Thermal diffusivities calculated
Mantle_diffusivity = (K_Mantle*3.6)./(Cp.*rho);
Atmosphere_diffusivity = (K_Atm.*0.05)./(Cp_atm.*rho_Atm);

% Time calculated in million years
ty=0:0.0001:0.01;       % one hundred years to ten thousand years
ky=0.02:0.01:0.1;       % twenty thousand years to one hundred thousand years
My=0.2:0.1:10;          % two hundred thousand years to ten million years
tMyrs=[ty ky My];       % Time calculated in million years

% This function create solidus and liquidus profiles
[Tsol, Tliq, Prof]=T_sol_liq;

% 
[xkm, sol11]=Heat_diffusion_SPH(InitialT,K_Mantle(1),K_Atm(1));
[xkm, sol14]=Heat_diffusion_SPH(InitialT,K_Mantle(1),K_Atm(4));
[xkm, sol41]=Heat_diffusion_SPH(InitialT,K_Mantle(4),K_Atm(1));
[xkm, sol44]=Heat_diffusion_SPH(InitialT,K_Mantle(4),K_Atm(4));

% Years = [0   100   1,000    10,000    100,000   1,000,000]
Times = [1     2     11      101        110        119];

% Color order = 'k','g','m','Orange','b','r'
mycolors = [0 0 0; 0 1 0; 1 0 1; 0.9290 0.6940 0.1250; 0 0 1; 1 0 0];

f1=figure('color','white');
subplot(2,2,1)
grid on
hold on
axis([3500 7000 0 8000])
ax = gca; 
ax.ColorOrder = mycolors;
for i=Times
plot(xkm,sol11(i,:))
end
plot(Prof,Tliq,'k--');
plot(Prof,Tsol,'k--');
lgd = legend('0 yrs','100 yrs','1 kyrs','10 kyrs','100 kyrs','1 Myrs',...
    'Solidus','Liquidus','FontSize',7,'Location','southwest'); lgd.NumColumns = 2;
xlabel('Earth^,s radius','FontSize',16),ylabel('Temperature','FontSize',16)
title('k_c_o_n_v: Mantle=10^2, Atm=10^2','FontSize',14)


subplot(2,2,2)
grid on
hold on
axis([3500 7000 0 8000])
ax = gca; 
ax.ColorOrder = mycolors;
for i=Times
plot(xkm,sol14(i,:))
end
plot(Prof,Tliq,'k--');
plot(Prof,Tsol,'k--');
lgd =legend('0 yrs','100 yrs','1 kyrs','10 kyrs','100 kyrs','1 Myrs',...
    'Solidus','Liquidus','FontSize',7,'Location','southwest'); lgd.NumColumns = 2;
xlabel('Earth^,s radius','FontSize',16),ylabel('Temperature','FontSize',16)
title('k_c_o_n_v: Mantle=10^2, Atm=10^5','FontSize',14)


subplot(2,2,3)
grid on
hold on
axis([3500 7000 0 8000])
ax = gca; 
ax.ColorOrder = mycolors;
for i=Times
plot(xkm,sol41(i,:))
end
plot(Prof,Tliq,'k--');
plot(Prof,Tsol,'k--');
lgd =legend('0 yrs','100 yrs','1 kyrs','10 kyrs','100 kyrs','1 Myrs',...
    'Solidus','Liquidus','FontSize',7,'Location','southwest'); lgd.NumColumns = 2;
xlabel('Earth^,s radius','FontSize',16),ylabel('Temperature','FontSize',16)
title('k_c_o_n_v: Mantle=10^5, Atm=10^2','FontSize',14)


subplot(2,2,4)
grid on
hold on
axis([3500 7000 0 8000])
ax = gca; 
ax.ColorOrder = mycolors;
for i=Times
plot(xkm,sol44(i,:))
end
plot(Prof,Tliq,'k--');
plot(Prof,Tsol,'k--');
lgd =legend('0 yrs','100 yrs','1 kyrs','10 kyrs','100 kyrs','1 Myrs',...
    'Solidus','Liquidus','FontSize',7,'Location','southwest'); lgd.NumColumns = 2;
xlabel('Earth^,s radius','FontSize',16),ylabel('Temperature','FontSize',16)
title('k_c_o_n_v: Mantle=10^5, Atm=10^5','FontSize',14)




%
% Final note: The figures were adapted to the extension of the monitor 
% that was used at the time of creating them. So there may possibly be 
% some aesthetic mismatches in the figure.
%








