function theta_bse = compute_BSE_theta(sim_results)
% Results are returned in radians

c = 1;
for i=1:length(sim_results.electrons_prop)

    if sim_results.electrons_prop(i).isBSE
        theta_bse(c) = sim_results.electrons_prop(i).theta(end);
        c = c + 1;
    end    
end

end