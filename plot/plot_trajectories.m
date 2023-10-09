function plot_trajectories(sim_results, num_traj, fig_number)

figure(fig_number)

% Num trajectories given in percentage
num_electrons = length(sim_results.electrons_prop);
disp(num_electrons);
if num_traj < num_electrons
    interval = floor(num_electrons / num_traj);
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

hold on
ax = gca;
ax.FontSize = 14;
qw{1} = plot(nan, 'r-', 'LineWidth', 1.5);
qw{2} = plot(nan, 'b-', 'LineWidth', 1.5);
legend([qw{:}], {'BSE', 'Absorbed'}, 'location', 'northeast', 'FontSize', 16)
xlabel('X [nm]', 'FontSize', 18)
ylabel('Y [nm]', 'FontSize', 18)
grid on 
hold off

end