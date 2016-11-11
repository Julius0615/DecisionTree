function entropy = information(labels,ratio)
% function information computes information contained at each node.

pos = sum(labels(:))/length(labels)+eps;
neg = (length(labels)-sum(labels(:)))/length(labels)+eps;
entropy = ratio*(-pos*log2(pos)-neg*log2(neg));