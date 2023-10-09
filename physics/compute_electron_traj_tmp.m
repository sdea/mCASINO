function electron_properties = compute_electron_traj_tmp(sim_params, sim_materials)

% Assign the parameters
E = sim_params.beam_E;



% Assign electron initial position
beam_pos = sim_params.beam_pos * 1E-07;
d = sim_params.beam_rad * 1E-07; % this accounts for d given in nm
y = beam_pos + d/2  * randn();

electron_properties.y_ini = y;

% Check the materials and assign the right properties
if y <= 0
    Z =   sim_materials.material1.Z;
    A =   sim_materials.material1.A;
    rho = sim_materials.material1.rho;
else

    Z =   sim_materials.material2.Z;
    A =   sim_materials.material2.A;
    rho = sim_materials.material2.rho;

end


x = 0;
theta = 0;


for i=1:sim_params.max_steps

    % Insert here a check for the material, and assign it correctly

    alpha = compute_alpha(E, Z);
    sigma = compute_sigma(E, Z, alpha);
    lambda_mean = compute_lambda(A, rho, sigma);
    step = compute_step(lambda_mean);

    theta_new = compute_scatt_angle(alpha);

    % Get the random on the   sign
    rand_sign = 2 * randi([0, 1]) - 1;
    theta_new = theta_new * rand_sign;

    theta = theta + theta_new;

    x = x + step * cos(theta);
    y = y + step * sin(theta);

    % Check the materials and assign the right properties
    if y <= 0
        Z =   sim_materials.material1.Z;
        A =   sim_materials.material1.A;
        rho = sim_materials.material1.rho;
    else

        Z =   sim_materials.material2.Z;
        A =   sim_materials.material2.A;
        rho = sim_materials.material2.rho;

    end

    if x < 0
        
        electron_properties.isBSE = true;
        electron_properties.x(i) = x;
        electron_properties.y(i) = y;
        electron_properties.E(i) = E;
        electron_properties.theta(i) = E;

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
        electron_properties.theta(i) = E;
    end
end

end