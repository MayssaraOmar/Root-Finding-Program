function [table,converged] = secant(x1, x2, es, f, max_iter) 
    table = [];
    converged = 1;
    syms root;
    i = 1;
    counter = 0;
    while i <= max_iter
        x3 = x2 - ((f(x2)*(x2 - x1))/(f(x2) - f(x1)));
        if(f(x3) == 0)
            newRow = {i, double(x1), f(double(x1)), double(x2), f(double(x2)), double(x3), f(double(x3)), 0};
            table = [table; newRow];
            converged = 1;
            break;
        end
        if(x3 == 0)
            ea = (abs(x3 - x2) / eps);
        else
            ea = (abs(x3 - x2) / abs(x3));
        end
        newRow = {i, double(x1), f(double(x1)), double(x2), f(double(x2)), double(x3), f(double(x3)), double(ea)};
        table = [table; newRow];
        if(ea <= es)
            converged = 1;
            break;
        end
        if(i>1&&ea>prev_ea)
            counter = counter + 1;
        end
        if(counter == 3)
            converged = 0;
        end
        xtemp = x2;
        x2 = x3;
        x1 = xtemp;
        i = i+1;
        prev_ea = ea;
    end
end