function [Time_Solidification]=T_lithos(Solution)
% This function serves to identify the moment of formation of the 
% lithosphere. The data entered must be a vector with surface 
% temperatures over time.


for i=1:1:length(Solution)

    if Solution(i) >= 1400
    
        Time_Sol(i)=i;
    
    else
    
        Time_Sol(i)=0;
    
    end
        
end

Time_Solidification=max(Time_Sol);

end