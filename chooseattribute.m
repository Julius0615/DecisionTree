function [best_feature,best_threshold,left,right] = ...
    chooseattribute(ft_lb,active_attrib_idx)
% function chooseattribute select the best feature and best threshold by
% calculating maximum gain
% if no more active attributes, best_feature = -1
% if the node is pure, best_feature = 0

current_information = information(ft_lb(:,end),1);

best_feature = -1;
best_threshold = -inf;
max_gain = -inf;
left = [];
right = [];

% if no more active attributes, the node is leaf
if isempty(active_attrib_idx)
    return;
end

% if the node is pure
if range(ft_lb(:,end)) == 0
    best_feature = 0;
    return;
end

for i = 1:length(active_attrib_idx)
    % sort the target feature and target (according to the target feature)
    tmp = ft_lb;
    [~,I] = sort(tmp(:,i));
    sorted = tmp(I,:);
    
    % try each threshold and compute gain
    for j = 1:(size(sorted,1)-1)
        th = (sorted(j,i)+sorted(j+1,i))/2;
        left_ = sorted(1:j,:);
        right_ = sorted(j+1:end,:);
        remainder = information(left_(:,end),size(left_,1)/size(sorted,1))...
            + information(right_(:,end),size(right_,1)/size(sorted,1));
        gain = current_information-remainder;
        
        if gain > max_gain
            max_gain = gain;
            best_feature = i;
            best_threshold = th;
            left = left_;
            right = right_;
        end
    end
end
