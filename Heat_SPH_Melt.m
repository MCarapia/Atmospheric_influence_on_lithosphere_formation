function [xkm, sol]=Heat_SPH_Melt(InitialT,MultipleConductivity,K_Atmosphere,time)
% This function solves the diffusivity equation. Initial conditions can be 
% selected, and the calculation uses effective thermal conductivity, 
% heat capacity and density. This equation is solved for planet Earth 
% after the giant impact. The calculation times are linearly spaced.


global rho Cp Cp_Atm InitialTprofile Ma_to_sec ssradius rho_Atm K_Atm MantleMultipleConductivity

    InitialTprofile=InitialT;
    K_Atm=K_Atmosphere;                              % k convective
    MantleMultipleConductivity=MultipleConductivity; % k convective

xkm=0:10:7000;  % radius in km. Roughly including the thermopause, as boundary of Energy system
x=xkm*1000;     % radius in meters

% tMyrs=0:1:500; % Calculation times
tMyrs=time;

Ma_to_sec=60*60*24*365*1e6;
t=tMyrs*Ma_to_sec; % Time in seconds
ssradius=6370000;  % Radius in m of the solid part of the planet
m=2;            % Symmetry factor to indicate spherical geometry.

% Material properties
%K=3.60;      % Thermal conductivity in Watts/(m K)
rho=3500;   % Density in kg/m3
Cp=1000;    % Heat capacity in J/(kg K)
rho_Atm=1;    % Density in kg/m3
Cp_Atm=2000;    % Heat capacity in J/(kg K)


sol=pdepe(m,@heatsph,@heatic,@heatbc,x,t);

end


function [c,f,s] = heatsph(x,t,u,dudx)

global rho Cp Cp_Atm ssradius rho_Atm K_Atm 

% The following conditions separate the thermal conductivities of the core  
% and mantle, and invoke a function that also allows a changing thermal
% conductivity on the mantle as a function of assumed solidus-liquidus
% temperatures.

 if x >= 3500000 && x < ssradius
    K1=VariableThermalConductivity(x,u);
    Diffusivity=K1/(rho*Cp); % Volumetric heat capacity
 elseif x < 3500000
    K1=100;
    rho_core=11000;
    Cp_core=700;
    Diffusivity=K1/(rho_core*Cp_core);
 else
    K1=K_Atm;
    Diffusivity=K1/(rho_Atm*Cp_Atm);
    % Diffusivity=0.000113; % thermal diffusivity of water vapor (steam)
end

    c=1; 
    f=Diffusivity*dudx; 
    s=0;


end

%----------------------- Initial conditions

function u0 = heatic(x)

    global InitialTprofile

    if InitialTprofile == 1
        if x <= 3500*1e3
            u0 = 5000;  
        elseif x > 3500*1e3 && x <= 5500*1e3
            u0 = 6000;
        elseif x > 5500*1e3 && x <= 6370*1e3
            u0 = 8000;
        else
            u0 = 4000;     % Space temperature outside the sphere
        end
    elseif InitialTprofile == 2
        if x <= 3500*1e3
            u0 = 4000;  
        elseif x > 3500*1e3 && x <= 5500*1e3
            u0 = 3500;
        elseif x > 5500*1e3 && x <= 6370*1e3
            u0 = 5000;
        else
            u0 = 2000;     % Space temperature outside the sphere
        end
    end


end


%-------------------Bondary conditions

function [pl,ql,pr,qr] = heatbc(xl,ul,xr,ur,t)

pl = ul; 
ql = 0; 
pr = ur;          % This insures constant temperature on the surface of the sphere
qr = 0;

end

% -----------------Variable thermal conductivity

function K1=VariableThermalConductivity(x,u)

global ssradius MantleMultipleConductivity

K=3.60; % W/m K Value of reference of solid rock 
Profundidad=(ssradius-x)/1000;
MP=Profundidad*27;   % kilometers to Megapascals
GP=MP/1000;          % Megapascals to Gigapascals

if GP <= 2.7
        Tsol = 1120.661 + 273.15 + (132.899*GP) - (5.904*(GP^2));
    elseif (2.7 < GP) && (GP <= 22.5)
        Tsol = 1086 + 273.15  - 5.7*GP + 390*log(GP);
    else % GP(i) > 22.5
        Tsol = 1762.722 + 31.595*GP - 0.102*GP^2;
end

if GP < 22.5
        Tliq =  2014.497 + (37.743*GP) - (0.472*(GP^2));
    else % GP(i) >= 22.5
        Tliq = 1803.547 + 50.810*GP - 0.185*GP^2;
end


Kliquid=K*MantleMultipleConductivity;  % thermal conductivity of the liquid.

if u >= Tliq
    K1=Kliquid;
elseif u < Tliq && u >= Tsol
    MeltFracc=(u - Tsol)/(Tliq - Tsol);
    K1= K + MeltFracc*(Kliquid-K);  % Linear dependence
else
    K1=K;
end

end



