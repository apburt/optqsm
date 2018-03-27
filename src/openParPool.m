%Andrew Burt - a.burt@ucl.ac.uk

function [pool] = openParPool(workers)
	p = parcluster('local');
	p.NumWorkers = workers;
	pool = parpool(p,p.NumWorkers);
end
