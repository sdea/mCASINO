function BSE_coeff = compute_BSE_coeff(sim_results)

num_BSE = count_BSE(sim_results);
num_electrons = length(sim_results.electrons_prop);

BSE_coeff = num_BSE / num_electrons;

end