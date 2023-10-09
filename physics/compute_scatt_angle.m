function theta = compute_scatt_angle(alpha)

% Rutherford model
rnd_number = rand();
cos_theta = 1 - ((2 * alpha * rnd_number))/(1 + alpha - rnd_number);
theta = acos(cos_theta);

end