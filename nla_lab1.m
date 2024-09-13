%% 1. Let us consider the function f (x) = (1 − cos x)/x2. Set x0 = 10−5
% a) Compute f (x0) and annotate the answer.
% b) Prove that f(x) < 1/2 (this has nothing to do with linear algebra, but
% with some elementary Calculus).
% c) According to b), is the result that you get for f(x0) correct?
% d) If your answer to b) is no, then explain which part of the calculation 
% is the source of the error.

%% Aux

% f(x)
function x = f(x)
    x = (1 - cos(x))/x^2;
end

% g(x)
function x = g(x)
    x = 0.5*(sin(x/2)/(x/2))^2;
end

% f'(x)
function x = fp(x)
    x = (2-cos(x)-x*sin(x))/x^3;
end

% g'(x)
function x = gp(x)
    x = sin(0.5*x)*(2*x*cos(0.5*x)-4*sin(0.5*x))/x^3;
end
 
% Relative conditioning number of f(x)
function x = Kf(x)
    x = abs(x)/abs(f(x))*fp(x);
end

% Relative conditioning number of g(x)
function x = Kg(x)
    x = abs(x)/abs(g(x))*gp(x);
end

% 1. a) Compute f (x0) and annotate the answer.
x0 = 10^-5;
fprintf('f(x0): %.16f\n', f(x0));
fprintf('Kf(x0): %.16f\n', Kf(x0));

% 2. b) Compute g(x0) and compare with the value of f(x0). Explain the 
% differences and where they come from.
fprintf('g(x0): %.16f\n', g(x0));
fprintf('Kg(x0): %.16f\n', Kg(x0));

% 3.) Repeat all developments in the previous two items using single precision arithmetic (command single in matlab).
x0 = single(x0)
fprintf('f(x0): %.16f\n', g(x0));
fprintf('Kg(x0): %.16f\n', Kg(x0));
fprintf('g(x0): %.16f\n', g(x0));
fprintf('Kg(x0): %.16f\n', Kg(x0));

x0 == 0