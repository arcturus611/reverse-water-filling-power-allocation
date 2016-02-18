%% Water filling analogy in power allocation for Gaussian power channel
% EE 515 Win 2016 HW 2
clear all; close all; clc;

%% Do the waterfilling
[sigma_vec, tot_distortion] = reversewaterfilling_init();
dist_alloc_vec = reversewaterfilling(sigma_vec, tot_distortion);

%% Visualize the stacked output
ceiling_drop = max(sigma_vec)+1 - dist_alloc_vec;
dist_alloc_bar = bar([dist_alloc_vec; sigma_vec - dist_alloc_vec; ceiling_drop - (sigma_vec - dist_alloc_vec)]', 'stacked');
set(dist_alloc_bar(1), 'FaceColor', 'yellow'); set(dist_alloc_bar(2), 'FaceColor', 'green');set(dist_alloc_bar(3), 'FaceColor', 'cyan');
str  = sprintf('Reverse water filling analogy for Gaussian channel bits allocation with total distortion constraint = %d', tot_distortion);
title(str);
channel_idx = 1:numel(sigma_vec);
set(gca, 'XTick', channel_idx);
xlabel('Channel index'); ylabel('Power level'); 
legend(dist_alloc_bar, {'distortion', 'signal power', 'water from ceiling'});

for i1=channel_idx
    if(dist_alloc_vec(i1)~=0)
        text(channel_idx(i1), .5*dist_alloc_vec(i1) - 0.25, num2str(dist_alloc_vec(i1),'%0.1f'),...
               'HorizontalAlignment','center', 'VerticalAlignment','bottom');
    end
    
    if(sigma_vec(i1)~=dist_alloc_vec(i1))
        text(channel_idx(i1), sigma_vec(i1) + 0.25, num2str(sigma_vec(i1),'%0.1f'),...
               'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontWeight', 'bold');
    end
end
