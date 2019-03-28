function [ Z ] = ssc_relaxed_lin_acc( X, lambda )
%% Solves the following
%
% min || X - XZ ||_F^2 + lambda || Z ||_1
%
% by accelerated gradient descent
%
% Created by Stephen Tierney
% stierney@csu.edu.au
%

max_iterations = 100;

func_vals = zeros(max_iterations, 1);
previous_func_val = Inf;

n = size(X, 2);

Z = zeros(n);
J = zeros(n);

rho = 1;
gamma = 1.1;

alpha = 1;

for k = 1 : max_iterations

    Z_prev = Z;
    alpha_prev = alpha;
    
    searching = true;
    while( searching )
        partial = -X'*X + X'*X*J;

        V = J - 1/rho * partial;

        Z = solve_l1(V, lambda/rho);
        
        Z(logical(eye(size(Z)))) = 0;
    
        func_vals(k, 1) =  lambda*norm_l1(Z) + 1/2 *norm(X - X*Z, 'fro')^2;
        
        approx = 0.5*norm(X - X*J, 'fro')^2 + sum(sum((Z - J).*partial)) + 0.5*rho*norm(Z - J, 'fro')^2 +  lambda*norm_l1(Z);
  
        if ( func_vals(k, 1) > approx )
            rho = gamma * rho;
        else
            searching = false;
        end
    end
    
    alpha = (1 + sqrt(1 + 4*alpha_prev^2)) / 2;
    
    J = Z + ((alpha_prev - 1)/alpha)*(Z - Z_prev);
    
    
    if ( abs(func_vals(k) - previous_func_val) <= 1*10^-6 )
        break;
    else
        previous_func_val = func_vals(k);
    end

end

end

