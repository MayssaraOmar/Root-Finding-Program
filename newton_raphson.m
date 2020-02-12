function [table,converged] = newton_raphson(x0, es, f, max_iter) 
    table = [];
    converged = 1;
    syms x;
    diff_f = matlabFunction(diff(f(x)));
    xr_old = x0;
    i = 1;
    counter = 0;
    while i <= max_iter
        xr_new = xr_old - (f(xr_old)/diff_f(xr_old));
        if(f(xr_new) == 0)
            newRow = {i, xr_old, f(xr_old), xr_new, f(xr_new), 0};
            table = [table; newRow];
            converged = 1;
            break;
        end
        if(xr_new == 0)
            ea = (abs(xr_new - xr_old) / eps);
        else
            ea = (abs(xr_new - xr_old) / abs(xr_new));
        end
        newRow = {i, xr_old, f(xr_old), xr_new, f(xr_new), ea};
        table = [table; newRow];
        if(ea <= es)
            converged = 1;
            break;
        end
        if(i>1)
            if(ea>prev_ea)
                counter = counter + 1;
            end
        end
        if(counter == 3)
            converged = 0;
        end
        xr_old = xr_new;
        i = i+1;
        prev_ea = ea;
    end
end