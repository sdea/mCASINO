function plot_trajectories(sim_results, num_traj, fig_number)

figure(fig_number)

% Num trajectories given in percentage
num_electrons = length(sim_results.electrons_prop);
disp(num_electrons);
if num_traj < num_electrons
    interval = floor(num_electrons / num_traj);
    disp(interval)
    %interval = 2;
else
    interval = 1;
end

hold on

for i=1:interval:length(sim_results.electrons_prop)
    
    x = 1E07 * sim_results.electrons_prop(i).x; 
    y = 1E07 * sim_results.electrons_prop(i).y;

if sim_results.electrons_prop(i).isBSE
    plot(y, -x, 'r-', 'LineWidth', 1.3)
else
    plot(y, -x, 'b-', 'LineWidth', 1.0)
end

end
hold off
legend({'Primary', 'BSE'}, 'FontSize', 14);
xlabel('X [nm]')
ylabel('Y [nm]')
grid on 

end