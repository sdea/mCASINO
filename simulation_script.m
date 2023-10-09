%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Simulation script 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear; 
close all; 

%% Define the material 

E_beam = 20;          % keV 
Z = 14;          % Silicon 
A = 28.0855;     % Atomic weight (g/mol) 
rho = 2.33;      % Density (g/cm3)

%% Let us define the loop for 1 electron 
x = 0;
y = 0;
theta = 0;
N_electrons = 10000;

for n=1:N_electrons
    
    % Reset parameters
    E = E_beam; 
    x = 0;
    y = 0;
    theta = 0;
    x_list = [];
    y_list = [];
    isBackscatter = false;
    fprintf('Working on electron: %d\n', n);
    
    for i=1:1000

        alpha = compute_alpha(E, Z);
        sigma = compute_sigma(E, Z, alpha);
        lambda_mean = compute_lambda(A, rho, sigma);
        step = compute_step(lambda_mean);

        theta_new = compute_scatt_angle(alpha);

        % Get the random on the sign
        rand_sign = 2 * randi([0, 1]) - 1;
        theta_new = theta_new * rand_sign;

        theta = theta + theta_new;


        x = x + step * cos(theta);
        y = y + step * sin(theta);

        if x < 0
            isBackscatter = true;
            break;
        else
            isBackscatter = false;
        end

        E_loss = compute_energy_loss(Z, E, rho, A, step);
        E = E + E_loss;

        if E <= 0.2
            break;
        else
            x_list(i) = x;
            y_list(i) = y;
        end
    end

    backscatter(n) = isBackscatter;
    x_list_final{n} = x_list;
    y_list_final{n} = y_list;

end


%% Visualize total trajectory

figure(2)
hold on
for n=1:100:N_electrons
    if backscatter(n) == true 
        plot(x_list_final{n}, y_list_final{n}, 'r-', 'LineWidth', 2.0)
    else
        plot(x_list_final{n}, y_list_final{n}, 'b-', 'LineWidth', 1.2)
    end
    
end
hold off
grid on

%% We try to plot it upside down
figure(3)
hold on

for n=1:100:N_electrons
    if backscatter(n) == true 
        plot(1E07 * y_list_final{n}, -1E07 * x_list_final{n}, 'r-', 'LineWidth', 1.5)
    else
        plot(1E07 * y_list_final{n}, -1E07 * x_list_final{n}, 'b-', 'LineWidth', 1)
    end
    
end
hold off

xlabel('X [nm]')
ylabel('Y [nm]')
grid on

%% BSE Coefficient
BSE_coeff = length(find(backscatter))/numel(backscatter);
disp(BSE_coeff);

%% Get the random distribution 
% Define the maximum width (standard deviation) you want
d = 0.5; % Adjust this value as needed

% Generate random numbers with a maximum width of d
% by scaling the standard normal distribution
randomNumbers = d * randn(1, 1000); % Generate 1000 random numbers, adjust the count as needed

% Plot a histogram to visualize the distribution
figure()
histogram(randomNumbers, 50); % Adjust the number of bins (50 in this example)
title('Random Numbers with Gaussian Distribution (mean = 0, std = d)');
xlabel('Value');
ylabel('Frequency');










