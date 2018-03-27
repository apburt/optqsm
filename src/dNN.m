%Andrew Burt - a.burt@ucl.ac.uk

function [nn] = dNN(cloud,nnearest)
	[idx,d] = knnsearch(cloud,cloud,'K',nnearest+1,'NSMethod','kdtree','Distance','euclidean');
	d = d(:,2:end);
	pmean = mean(d,2);
	nn = mean(pmean);
end
