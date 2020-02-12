function table = false_position(xlower, xupper, es, f, max_iter) 
    table = [];
    if(f(xupper)*f(xlower) > 0)
        disp('no roots in this interval');
        return;
    end
    if(f(xlower) > 0)
        [xupper, xlower] = deal(xlower, xupper);
    end
    prev_xr = 0; 
    i = 1;
    ea = nan;
    while i <= max_iter
        xr = (xlower*f(xupper) - xupper*f(xlower))/(f(xupper) - f(xlower));
        if(f(xr) == 0)
            newRow = {i, xlower, f(xlower), xupper, f(xupper), xr, f(xr), 0};
            table = [table; newRow];
            break;
        end
        if(i>1)
            if(xr == 0)
                ea = (abs(xr - prev_xr) / eps);
            else
                ea = (abs(xr - prev_xr) / abs(xr));
            end
        end
        newRow = {i, xlower, f(xlower), xupper, f(xupper), xr, f(xr), ea};
        table = [table; newRow];
        if(ea <= es)
            break;
        end
        if f(xr) < 0 
           xlower = xr;
        else 
           xupper = xr;          
        end
        prev_xr = xr;
        i = i+1;
    end
end
