function table = bisection(xlower, xupper, es, f, max_iter) 
    table = [];
    if(f(xupper)*f(xlower)>0)
        disp('no roots in this interval');
        return;
    end
    prev_xr = 0;
    i = 1;
    ea = nan;
    while i <= max_iter 
        xr = (xlower + xupper)/2;
        if(f(xr) == 0)
            newRow = {i, xlower, f(xlower), xupper, f(xupper), xr, f(xr), 0};
            table = [table; newRow];
            break;
        end
        if(i>1)
            if(xr == 0)
                ea = abs(xr - prev_xr)/ eps;
            else
                ea = (abs(xr - prev_xr) / abs(xr));
            end
        end
        newRow = {i, xlower, f(xlower), xupper, f(xupper), xr, f(xr), ea};
        table = [table; newRow];
        if(ea <= es)
            break;
        end
        if f(xlower)*f(xr) < 0 %diff signs
           xupper = xr;
        else %same sign
           xlower = xr;          
        end
        prev_xr = xr;
        i = i+1;
    end
end
