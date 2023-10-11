function z_max = compute_zmax(sim_results)

for i=1:length(sim_results.electrons_prop)
    z_max(i) = max(sim_results.electrons_prop(i).x); 
end

end