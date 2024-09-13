function P = wilkinson_polynomial(n)
    syms x;
    Pn = prod(x-(1:n));
    P = expand(Pn);
end


function P_perturbed = perturb_wilkinson(P, degree_to_perturb, epsilon)
    % Extract coefficients of the symbolic polynomial
    coeffs_P = fliplr(coeffs(P, 'All'));
    
    % Random perturbation factor
    r = rand();
    
    % Apply the perturbation to the coefficient of the specific degree
    idx = degree_to_perturb + 1;
    coeffs_P(idx) = coeffs_P(idx) * (1 + epsilon * r);
    
    % Reconstruct the polynomial with the perturbed coefficient
    syms x;
    P_perturbed = poly2sym(fliplr(coeffs_P), x);
end

%% 3.3

% Expand de polynomial for n=20
P20 = wilkinson_polynomial(20);
latex_code = latex(P20);
disp('Polynomial for n=20 for LaTeX')
disp(latex_code);

% Perturb the coefficient of degree 15 with epsilon = 10^(-10)
degree_to_perturb = 15;
epsilon = 1e-10;
P20_perturbed = perturb_wilkinson(P20, degree_to_perturb, epsilon);

% Display the perturbed polynomial
disp('Perturbed Wilkinson Polynomial:');
disp(P20_perturbed);
disp('In LaTeX:');
disp(latex(P20_perturbed));




% Get the coefficients of the original and perturbed polynomials
coeffs_W20 = flipud(coeffs(P20, 'All'));
coeffs_W20_perturbed = flipud(coeffs(P20_perturbed, 'All'));

% Compute the roots
roots_W20 = roots(coeffs_W20);
roots_W20_perturbed = roots(coeffs_W20_perturbed);

%% 3.4
figure;
hold on;
plot(real(roots_W20), imag(roots_W20), 'bo', 'DisplayName', 'Original W_{20} Roots');
plot(real(roots_W20_perturbed), imag(roots_W20_perturbed), 'r.', 'DisplayName', 'Perturbed W_{20} Roots');
legend('show');
xlabel('Real Part');
ylabel('Imaginary Part');
title('Roots of W_{20}(x) and Perturbed W_{20}(x)');
grid on;
hold off;


% Adjust figure to remove excess white space
ax = gca;
exportgraphics(ax,'3_4.png','Resolution',300) 



%% 3.5
function P_all_perturbed = perturb_all_wilkinson(P, epsilon)
    % Extract coefficients of the symbolic polynomial
    coeffs_P = fliplr(coeffs(P, 'All'));
    
    % Random perturbation factor
    r = rand();
    
    % Apply the perturbation to all coefficients but the first
    for idx = 1:length(coeffs_P)-1
        coeffs_P(idx) = coeffs_P(idx) * (1 + epsilon * r);
    end
    % Reconstruct the polynomial with the perturbed coefficient
    syms x;
    P_all_perturbed = poly2sym(fliplr(coeffs_P), x);
end




% Perturb the coefficients with epsilon = 10^(-10)
epsilon = 1e-10;


%Begin plot
figure;
hold on;
plot(real(roots_W20), imag(roots_W20), 'bo', 'DisplayName', 'Original W_{20} Roots');

for i = 1:100
    %Perturb coefficients, and compute the roots
    P20_all_perturbed = perturb_all_wilkinson(P20, epsilon);
    coeffs_W20_all_perturbed = flipud(coeffs(P20_all_perturbed, 'All'));
    roots_W20_all_perturbed = roots(coeffs_W20_all_perturbed);
    
    %Plot in each iteration
    plot(real(roots_W20_all_perturbed), imag(roots_W20_all_perturbed), 'r.');
end

%Finish plot
xlabel('Real Part');
ylabel('Imaginary Part');
title('Roots of W_{20}(x) and Perturbed W_{20}(x)');
grid on;
hold off;



% Save the figure
ax = gca;
exportgraphics(ax,'3_5.png','Resolution',300) 
