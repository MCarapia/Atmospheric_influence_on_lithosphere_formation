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



xkm=0:10:7000;  % radius in km.
x=xkm*1000;     % radius in meters

% This function create solidus and liquidus profiles
[Tsol, Tliq, Prof]=T_sol_liq;

%
Times_Crust1=zeros(length(K_Mantle),length(K_Atm));
Times_Crust2=zeros(length(K_Mantle),length(K_Atm));
Time_Mantle1=zeros(length(K_Mantle),length(K_Atm));
Time_Mantle2=zeros(length(K_Mantle),length(K_Atm));
% n=[1:7;	8:14; 15:21; 22:28; 29:35; 36:42; 43:49];
% Solution1=zeros(length(tMyrs),length(x),49);
% Solution2=zeros(length(tMyrs),length(x),49);


for i = 1:1:length(K_Mantle)
    for j = 1:1:length(K_Atm)

if i >= 6 
    FT = 200;
elseif i > 2 && i < 6
    FT = 300;
else 
    FT = 500;
end

% Time calculated in million years
        ty=0:0.0001:0.01;                         
        ky=0.02:0.01:1;                      
        Myrs=2:1:FT;
        tMyrs=[ty ky Myrs];   % Calculation times


% N=n(i,j);
% This function calculate 
    [xkm, sol1]=Heat_SPH_Melt(1,K_Mantle(i),K_Atm(j),tMyrs);
% This function calculates how long it takes for the surface to drop below 1400 K.
    [T_S_1]=T_lithos(sol1(:,638));
% This stores the solidification times of the surface.
    Times_Crust1(i,j)=tMyrs(T_S_1);
%     Solution1(:,:,N)=sol1(:,:);


% This function calculate 
    [xkm, sol2]=Heat_SPH_Melt(2,K_Mantle(i),K_Atm(j),tMyrs);
% This function calculates how long it takes for the surface to drop below 1400 K.
    [T_S_2]=T_lithos(sol2(:,638));
% This stores the solidification times of the surface.
    Times_Crust2(i,j)=tMyrs(T_S_2);
%     Solution2(:,:,N)=sol2(:,:);
    

    [Time_SolidMantle1]=Meltpercentage(sol1(:,351:638),tMyrs);
    Time_Mantle1(i,j)=Time_SolidMantle1;

    [Time_SolidMantle2]=Meltpercentage(sol2(:,351:638),tMyrs);
    Time_Mantle2(i,j)=Time_SolidMantle2;


a=i
b=j
    end
end





AllSolid_1=Time_Mantle1./Times_Crust1;
AllSolid_2=Time_Mantle2./Times_Crust2;



% Figures
%%

f1=figure('color','white');
subplot(2,2,1)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s1=surf(K_Atm,K_Mantle,Times_Crust1,'FaceAlpha',0.85); c1=colormap('jet'); clim([0 0.11]);
c=colorbar; shading interp
c.Label.String = 'Lithosphere solidification (Years)'; c.Label.FontSize = 14; 
c.Limits = [0 0.11];
c.Ticks = [0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11];
c.TickLabels = {'0','10,000','20,000','30,000','40,000','50,000','60,000','70,000','80,000','90,000','100,000','>100,000'};
s1.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log'; 
title('Maximum temperatures')

subplot(2,2,2)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s1=surf(K_Atm,K_Mantle,Times_Crust2,'FaceAlpha',0.85); c1=colormap('jet'); clim([0 0.11]);
c=colorbar; shading interp
c.Label.String = 'Lithosphere solidification (Years)'; c.Label.FontSize = 14; 
c.Limits = [0 0.11];
c.Ticks = [0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11];
c.TickLabels = {'0','10,000','20,000','30,000','40,000','50,000','60,000','70,000','80,000','90,000','100,000','>100,000'};
s1.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log';
title('Minimum temperatures')

subplot(2,2,3)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s2=surf(K_Atm,K_Mantle,Time_Mantle1,'FaceAlpha',0.85); c2=colormap('autumn'); clim([0 500]);
c=colorbar; shading interp
c.Label.String = 'Mantle solidification (Myrs)'; c.Label.FontSize = 14; 
s2.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log'; 
title('Maximum temperatures')

subplot(2,2,4)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s2=surf(K_Atm,K_Mantle,Time_Mantle2,'FaceAlpha',0.85); c2=colormap('autumn'); clim([0 500]);
c=colorbar; shading interp
c.Label.String = 'Mantle solidification (Myrs)'; c.Label.FontSize = 14; 
s2.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log';
title('Minimum temperatures')




f3=figure('color','white');
subplot(1,2,1)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s3=surf(K_Atm,K_Mantle,AllSolid_1,'FaceAlpha',0.85); colormap('turbo'); clim([100 1100000]);
c=colorbar; shading interp
c.Label.String = 'Solidification time ratio'; c.Label.FontSize = 14; 
c.Limits = [100 1100000];
s3.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log'; 
title('Maximum temperatures')

subplot(1,2,2)
grid on, hold on
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('k_c_o_n_v Mantle','FontSize',16)
s3=surf(K_Atm,K_Mantle,AllSolid_2,'FaceAlpha',0.85); colormap('turbo'); clim([100 1100000]);
c=colorbar; shading interp
c.Label.String = 'Solidification time ratio'; c.Label.FontSize = 14; 
c.Limits = [100 1100000];
s3.EdgeColor = 'none';
ax = gca;
ax.XScale = 'log'; 
ax.YScale = 'log';
title('Minimum temperatures')



% Color order = 'b','r','k','g','m','Orange',
mycolors = [0 0 1; 1 0 0; 0 0 0; 0 1 0];

f4=figure('color','white');
subplot(1,2,1)
grid on
hold on
ax = gca; 
ax.ColorOrder = mycolors;
ax.XScale = 'log'; 
ax.YScale = 'log';
for i=[1 3 5 7]
plot(K_Atm,AllSolid_1(i,:))
end
legend('k_c_o_n_v Mantle=10^2','k_c_o_n_v Mantle=10^3','k_c_o_n_v Mantle=10^4'...
    ,'k_c_o_n_v Mantle=10^5','FontSize',14,'Location','southeast');
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('Solidification time ratio','FontSize',16)
title('Maximum temperatures')

subplot(1,2,2)
grid on
hold on
ax = gca; 
ax.ColorOrder = mycolors;
ax.XScale = 'log'; 
ax.YScale = 'log';
for i=[1 3 5 7]
plot(K_Atm,AllSolid_2(i,:))
end
legend('k_c_o_n_v Mantle=10^2','k_c_o_n_v Mantle=10^3','k_c_o_n_v Mantle=10^4'...
    ,'k_c_o_n_v Mantle=10^5','FontSize',14,'Location','southeast');
xlabel('k_c_o_n_v Atmosphere','FontSize',16),ylabel('Solidification time ratio','FontSize',16)
title('Minimum temperatures')




















%
% Final note: The figures were adapted to the extension of the monitor 
% that was used at the time of creating them. So there may possibly be 
% some aesthetic mismatches in the figure.
%








