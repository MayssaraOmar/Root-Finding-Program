function table = fixed_point(x0, es, g, max_iter) 
    table = [];
    xr_old = x0;
    i = 1; 
    while i <= max_iter
        xr_new = g(xr_old);
        if(xr_new == 0)
            ea = (abs(xr_new - xr_old) / eps);
        else
            ea = (abs(xr_new - xr_old) / abs(xr_new));
        end
        newRow = {i, xr_old, g(xr_old), xr_new, g(xr_new), ea};
        table = [table; newRow];
        if(ea <= es)
            break;
        end
        i = i+1;
        xr_old = xr_new;
    end
end