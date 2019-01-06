
function g = make2DGaussian(N, sigma)
% N is odd, and so the origin (0,0) is positioned at indices
% (M+1,M+1) where N = 2*M + 1.

M=(N-1)/2;
g = [];                                        
    for row=1:N    
        for column=1:N       
        pos=double((row-M-1)^2+(column-M-1)^2);        
        g(row,column)=exp(-pos/(2*sigma*sigma))/(2*pi*sigma);    
        end
    end

g=g/sum(g(:));  

%normalization

end


