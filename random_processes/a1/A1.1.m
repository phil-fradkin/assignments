% Question 1 a, b

number_iterations = 100
z_vector = []
cdf_vector = []

for iteration = 1:number_iterations  
    cdf_val = rand();
    cdf_vector = [cdf_vector, cdf_val];
    
    if cdf_val < 0.5
        z = 2 * cdf_val;
    else
        z = 4 * cdf_val - 1;
    end
        
    z_vector = [z_vector, z];
end
    
hist(z_vector)
title('Histogram of generated samples N = 100')
ylabel('count')
xlabel('sample value')
saveas(gcf, '~/Documents/assignments/random_processes/a1/z100_sample_hist.png')

disp(mean(z_vector))
disp(var(z_vector))

% Question 1c

iterations_count = [100, 200, 300, 400, 500, 1000, 2000, 5000]
sample_var = []
sample_mean = []

for number_iterations = iterations_count;
    z_vector = []
    cdf_vector = []

    for iteration = 1:number_iterations  
        cdf_val = rand();
        cdf_vector = [cdf_vector, cdf_val];

        if cdf_val < 0.5
            z = 2 * cdf_val;
        else
            z = 4 * cdf_val - 1;
        end

        z_vector = [z_vector, z];
    end
    sample_var = [sample_var, var(z_vector)]
    sample_mean = [sample_mean, mean(z_vector)]
    
end
categorical
s = scatter(categorical(iterations_count), sample_mean, 'filled')
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];

title("Scatterplot of sample mean vs sample count")
xlabel('Sample count') 
ylabel('Sample mean') 
saveas(gcf, '~/Documents/assignments/random_processes/a1/sample_mean_scatter.png')

s = scatter(categorical(iterations_count), sample_var, 'filled')
s.LineWidth = 0.6;
s.MarkerEdgeColor = 'b';
s.MarkerFaceColor = [0 0.5 0.5];
title("Scatterplot of sample variance vs sample count")
xlabel('Sample count') 
ylabel('Sample variance') 
saveas(gcf, '~/Documents/assignments/random_processes/a1/sample_variance_scatter.png')
