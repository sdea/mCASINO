function num_BSE = count_BSE(sim_results)

num_BSE = 0;
for i=1:length(sim_results.electrons_prop)
    num_BSE = num_BSE + sim_results.electrons_prop(i).isBSE;
end

end