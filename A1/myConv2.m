function im = myConv2(image, filter)

[fr, fc] = size(filter);
image = padarray(image,[(fr-1)/2,(fc-1)/2]);
[ir, ic] = size(image);    

outr = ir - fr +1;      
outc = ic - fc +1;

im = zeros(outr, outc);

for yr = 1:outr            % loop over output
    for yc = 1:outc
        sum = 0;
        for mr = 1:fr    % loop over each element, mask
            for mc = 1:fc
                sum = sum + image(yr-mr+fr, yc-mc+fc) * filter(mr, mc);
            end
        end
        im(yr, yc) = sum;  
    end
end

end