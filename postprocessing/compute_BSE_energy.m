function bse_energy = compute_BSE_energy(sim_results)

c = 1;
for i=1:length(sim_results.electrons_prop)

    if sim_results.electrons_prop(i).isBSE
        bse_energy(c) = sim_results.electrons_prop(i).E(end);
        c = c + 1;
    end    
end

end