function final_dist_alloc_vec = reversewaterfilling(sigma_vec, tot_dist)
%i am going to try to make this code a little more readable
num_channels = numel(sigma_vec);
[sorted_pow, sorted_idx] = sort(sigma_vec);
[unq_sorted_pow, unq_idx]= unique(sorted_pow);
num_unq_pow = numel(unq_sorted_pow);
cmp_and_thres_mat = bsxfun(@min, repmat(sorted_pow', 1, num_unq_pow), repmat(unq_sorted_pow, num_channels, 1));
tot_used_dist = sum(cmp_and_thres_mat, 1);

overflow_point = find(tot_used_dist > tot_dist, 1);
% edge cases:
if(overflow_point == 1)
    final_dist_alloc_vec = (tot_dist/num_channels)*ones(1, num_channels);
elseif (isempty(overflow_point))
    final_dist_alloc_vec = sigma_vec;
else
    overflow_vec = bsxfun(@min, sorted_pow, unq_sorted_pow(overflow_point));
    overflow_idx = overflow_vec==unq_sorted_pow(overflow_point);
    num_overflow_bins = sum(overflow_idx);
    res_dist = tot_dist - sum(bsxfun(@min, sorted_pow, unq_sorted_pow(overflow_point -1)));
    mod_dist_per_overflow_bin = res_dist/num_overflow_bins;
    overflow_vec(overflow_idx) = mod_dist_per_overflow_bin + unq_sorted_pow(overflow_point - 1);
    
    final_dist_alloc_vec = zeros(1, num_channels);
    final_dist_alloc_vec(sorted_idx) = overflow_vec; 
end
end