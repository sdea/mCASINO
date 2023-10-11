function zmax_bse = compute_zmax_bse(sim_results)

c = 1;
for i=1:length(sim_results.electrons_prop)

    if sim_results.electrons_prop(i).isBSE
        zmax_bse(c) = max(sim_results.electrons_prop(i).x); 
        c = c + 1;
    end
    
end

end