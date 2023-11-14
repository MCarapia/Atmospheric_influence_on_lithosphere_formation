function[T_sol, T_liq, Profundidad] = T_sol_liq(PlanetRadius,BaseofMantle)
% This function allows obtaining the solidus and liquidus curves for the mantle.



if nargin == 0
    PlanetRadius=6370;
    BaseofMantle=3500;
end

Profundidad_km=PlanetRadius:-1:BaseofMantle;
Deep=PlanetRadius-Profundidad_km;
MP=Deep.*27; % Conversion from kilometers to Megapascals
GP=MP./1000; % Conversion from Megapascals to Gigapascals

PressureBaseOfMantle=(PlanetRadius-BaseofMantle)*27/1000;


for i=1:length(GP)
    if GP(i)<=2.7
        Tsol(:,i) = 1120.661 + 273.15 + (132.899*GP(i)) - (5.904*(GP(i)^2));
    elseif (2.7 < GP(i)) && (GP(i)<= 22.5)
        Tsol(:,i) = 1086 + 273.15  - 5.7*GP(i) + 390*log(GP(i));
    elseif GP(i) > 22.5
        Tsol(:,i) = 1762.722 + 31.595*GP(i) - 0.102*GP(i)^2;
    else
    end
end

for i=1:length(GP)
    if GP(i) < 22.5
        Tliq(:,i) =  2014.497 + (37.743*GP(i)) - (0.472*(GP(i)^2));
    elseif GP(i) >= 22.5
        Tliq(:,i) = 1803.547 + 50.810*GP(i) - 0.185*GP(i)^2;
    else
    end
end


T_sol = Tsol;
T_liq = Tliq; 
Profundidad = Profundidad_km;


end


