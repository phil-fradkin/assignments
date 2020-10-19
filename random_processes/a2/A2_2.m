% Question 2a

var_sum = 0;
vector_of_averages = [];

for iteration = 1:1000
    random_val_sampled = rand();
    var_sum = var_sum + random_val_sampled;
    
    vector_of_averages = [vector_of_averages, var_sum / iteration];
end

s = scatter(1:1000, vector_of_averages, 'filled');
saveas(gcf, '~/Documents/assignments/random_processes/a2/scatter_s_n_converges_with_n.png')


% Question 2b

vector_of_z_n = [];

for iteration = 1:1000
    s_n = create_s_n(100)
    z_n = (s_n - 50) / sqrt(100/12);
    
    vector_of_z_n = [vector_of_z_n, z_n];
end

h = histogram(vector_of_z_n)
saveas(gcf, '~/Documents/assignments/random_processes/a2/histogram_z_n.png')




% Q 2c
xStart = -3;
dx = 0.01;
N = 600;
x = xStart + (0:N-1)*dx;

compPlot = figure('Name', 'Comparison of Stuff');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
plot(x, normpdf(x))
yyaxis right
h = histogram(vector_of_z_n)
legend('PDF of Normal','Histogram of Z random variables');
hold(ax1, 'off');
saveas(gcf, '~/Documents/assignments/random_processes/a2/hist_line_normal_clt.png')


% Q 2 d

mean(vector_of_z_n)
var(vector_of_z_n)
% other way to compute variance
mean((vector_of_z_n - mean(vector_of_z_n)).^2)

function [value_s_n] = create_s_n(num_samples)
    value_s_n = 0;
    for iteration = 1:num_samplessd
        random_val_sampled = rand();
        value_s_n = value_s_n + random_val_sampled;
    end
end
