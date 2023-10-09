function sigma = compute_sigma(E, Z, alpha)

numeric_factor = 5.21E-21 * (Z^2)/(E^2);
alpha_factor = (4 * pi) / (alpha * (1 + alpha));
energy_factor = ((E + 511)/(E + 1024))^2;

sigma = numeric_factor * alpha_factor * energy_factor;

end
