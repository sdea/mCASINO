function E_loss = compute_energy_loss(Z, E, rho, A, step)

J = compute_J(Z);
dEdS = -78500 * ((rho * Z) / (A * E)) * log((1.166 * E) / J + 1);
E_loss = step * dEdS;

end