function [Time_SolidMantle]=Meltpercentage(Sol,tMyrs)

xkm=3500:10:6370;  % radius in km.
x=xkm*1000;     % radius in meters

%         ty=0:0.0001:0.01;                         
%         ky=0.02:0.01:1;                       
%         t=0:1:500;
%         t=[ty ky Myrs];   % Calculation times
t=tMyrs;

for j=1:1:length(x)

Profundidad=(6370000-x(j))/1000;
MP=Profundidad*27;   % Conversion de kilometros a Megapascales
GP=MP/1000;             % Conversion de Megapascales a Gigapascales

        if GP <= 2.7
                Tsol = 1120.661 + 273.15 + (132.899*GP) - (5.904*(GP^2));
            elseif (2.7 < GP) && (GP <= 22.5)
                Tsol = 1086 + 273.15  - 5.7*GP + 390*log(GP);
            else % GP(k) > 22.5
                Tsol = 1762.722 + 31.595*GP - 0.102*GP^2;
        end
        
        if GP < 22.5
            Tliq =  2014.497 + (37.743*GP) - (0.472*(GP^2));
        else % GP(i) >= 22.5
            Tliq = 1803.547 + 50.810*GP - 0.185*GP^2;
        end

    for i=1:1:length(t)

            Melt_frac = (Sol(i,j) - Tsol)./(Tliq - Tsol);
        
            if Melt_frac > 1
                Melt_frac = 1;
            elseif Melt_frac <= 0 
                Melt_frac = 0;
            else 
            end
            
%---------------------------------------------
            Melt1 (i,j)= Melt_frac;

    end
end

for i=1:1:length(t)
    Max_Percentage=max(Melt1(i,:));

    if Max_Percentage > 0.1
        Melt_Percentage(i) = 500;
    else 
        Melt_Percentage(i) = t(i);
    end


end

Time_SolidMantle = min(Melt_Percentage);



Melt=Melt1;



end






















