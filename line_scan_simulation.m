%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Line scan simulation across an interface   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear; 

%% Set the parameters of the simulation
sim_param.beam_E = 20;
sim_param.beam_rad = 50;
sim_param.beam_pos = 0; % Position of the center [nm]
sim_param.tilt = 0;
sim_param.threshold_energy = 0.1;
sim_param.max_steps = 10000;
sim_param.num_electrons = 20;

%% Set the materials
material1 = get_element_properties('Fe');
material2 = get_element_properties('Si');

%% Set the materials struct 
sim_materials.material1 = material1;
sim_materials.material2 = material2;

%% For loop across an interface 
%  100 points

pix_size = 100;         % [nm]
image_width = 100;      % [px]
image_height = 100;      % [px]

for i=1:image_width

    for j=1:image_height

        fprintf('Point: %d / %d\n', i, image_width);

        beam_pos = (-image_width/2 + i) * pix_size;
        sim_param.beam_pos = beam_pos;

        % Iterate on the number of electrons
        tic;
        for k=1:sim_param.num_electrons
            el_prop = compute_electron_traj_tmp(sim_param, sim_materials);
            sim_results.electrons_prop(k) = el_prop;
        end
        toc;

        sim_result_list{i, j} = sim_results;

    end
end

%% Insepct the result list
plot_trajectories(sim_result_list{5}, 300, 1);


%% Make calculations
for i=1:image_width
    for j=1:image_height

        num_BSE(i, j) = count_BSE(sim_result_list{i, j});

    end
end

%% Image 
figure(2)
imagesc(num_BSE), colormap("gray")
axis image





