function [ Z ] = lrr_relaxed( X, lambda )
%% Solves the following
%
% min || X - XZ ||_F^2 + lambda || Z ||_*
%
% via ADM
%
% Created by Stephen Tierney
% stierney@csu.edu.au
%

max_iterations = 200;

func_vals = zeros(max_iterations, 1);

n = size(X, 2);

Z = zeros(n);
J = zeros(n);
Y = zeros(n);

mu = 1;

tol_1 = 1*10^-2;
tol_2 = 1*10^-4;

for k = 1 : max_iterations
    k
    Z_prev = Z;
    J_prev = J;
    
    % Solve for J
    
    J = (X'*X + mu*speye(size(J))) \ (X'*X + Y + mu*Z);
    
    % Solve for Z
    
    V = J - (1/mu) * Y;
    
    [Z, s] = solve_nn(V, lambda / mu );
    
    % Update Y
    
    Y = Y + mu*(Z - J);
    
    % Check convergence
    
    func_vals(k) = 0.5*norm(X - X*Z, 'fro')^2 + lambda * sum(s);
    
    if ( norm(J - Z, 'fro') < tol_1 ...
            && (mu * max([ norm(Z - Z_prev,'fro'), norm(J - J_prev, 'fro')]) < tol_2))
        break;
    end
    
end

end

