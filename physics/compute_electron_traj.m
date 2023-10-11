function electron_properties = compute_electron_traj(sim_params, material)

% Assign the parameters
E = sim_params.beam_E;
Z = material.Z;
A = material.A;
rho = material.rho;

% Assign electron initial position
d = sim_params.beam_rad * 1E-07; % this accounts for d given in nm
y = d/2  * randn();

electron_properties.y_ini = y;

x = 0;
theta = 0;

for i=1:sim_params.max_steps

    % Insert here a check for the material, and assign it correctly

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

        electron_properties.isBSE = true;
        electron_properties.x(i) = 0;
        electron_properties.y(i) = y;
        electron_properties.E(i) = E;
        electron_properties.theta(i) = theta;

        break;
    else
        electron_properties.isBSE = false;
    end

    E_loss = compute_energy_loss(Z, E, rho, A, step);
    E = E + E_loss;

    if E <= sim_params.threshold_energy
        break;
    else
        electron_properties.x(i) = x;
        electron_properties.y(i) = y;
        electron_properties.E(i) = E;
        electron_properties.theta(i) = theta;
    end
end

end