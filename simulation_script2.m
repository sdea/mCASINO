%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Simulation script simplified with proper structs  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear; 

%% Set the parameters of the simulation
sim_param.beam_E = 20;
sim_param.beam_rad = 100;
sim_param.tilt = 0;
sim_param.beam_pos = 5000;
sim_param.threshold_energy = 0.1;
sim_param.max_steps = 10000;
sim_param.num_electrons = 300;

%% Set the materials
%  Only bulk is defined
material1 = get_element_properties('Fe');
material2 = get_element_properties('C');

%% Make an interface 
sim_materials.material1 = material1;
sim_materials.material2 = material2;


%% Final simulations with more electrons 
for i=1:sim_param.num_electrons
    el_prop = compute_electron_traj_tmp(sim_param, sim_materials);
    sim_results.electrons_prop(i) = el_prop;
end

%% Plot with function
plot_trajectories(sim_results, 100, 2);


