function bse_radii = compute_BSE_radii(sim_results)

c = 1;
for i=1:length(sim_results.electrons_prop)

    if sim_results.electrons_prop(i).isBSE
        bse_radii(c) = abs(sim_results.electrons_prop(i).y(end));
        c = c + 1;
    end    
end


end