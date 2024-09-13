% 2. Write a matlab code that computes the determinant of an n × n matrix 
% using the Laplace expansion by the first column, and that gives you the 
% execution time involved in this computation.

function d = Laplace(N)
 [~,sz] = size(N);
 d = 0;
 if sz == 1
     d = N;
 else
     for i=1:sz              
         n = N([1:i-1, i+1:sz], 2:sz); % remove first column and skip the i row         
         d = d + (-1)^(i+1)*N(i,1)*Laplace(n);
     end
 end 
end

function t = LaplaceTime(N)
    tic;
    d = Laplace(N);
    t = toc;
end

% Example
a = [1 6 1.5; 3 5 4; 1 8 9];
d = Laplace(a);

% 3. Run your code with matrices of sizes n = 5,6,7,8,9,10 and annotate the execution time. 
% Is this is accordance with the computational complexity estimated in part 1?

rng(123); % Sets the seed to 123

range = 5:10;
t = zeros(1,length(range)); % Realized execution time
o = zeros(1,length(range)); % Expected

for i=range
    r = rand(i,i);    
    t(i-(range(1)-1)) = LaplaceTime(r);    
    o(i-(range(1)-1)) = factorial(i);
    % fprintf('Matrix size: %d, Execution time: %.6f seconds\n', i, t(i-(range(1)-1)));    
end
o = o / max(o) * max(t);

figure;
plot(range, t, '-o');
hold on;
plot(range, o, '-o');
xlabel('Matrix Size (n)');
ylabel('Execution Time (seconds)');
title('Execution Time for Laplace Expansion by Matrix Size');
legend('Realized execution time', 'Normalized theoretical time (N!)');
hold off;

% 4. How much time would, approximately, take your computer to calculate 
% the determinant of a 12 × 12 matrix using your code? And what about a 20 × 20 
% determinant?

et12 = t(end)*factorial(12)/factorial(range(end));
et20 = t(end)*factorial(20)/factorial(range(end));
fprintf('Matrix size: 12, Estimated Execution time: %.6f seconds\n', et12);    
fprintf('Matrix size: 20, Estimated Execution time: %.6f seconds\n', et20);    
o(end+1) = et12;
o(end+1) = et20;
range(end+1) = 12;
range(end+1) = 20;
figure;
plot(range, o, '-o');
xlabel('Matrix Size (n)');
ylabel('Execution Time (seconds)');
title('Execution Time for Laplace Expansion by Matrix Size');
legend('Normalized theoretical time (N!)');

