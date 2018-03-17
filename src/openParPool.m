% Andrew Burt - a.burt@ucl.ac.uk

function [] = openParPool(workers)
    pool = parcluster('local');
    pool.NumWorkers = workers;
    parpool(pool,pool.NumWorkers);
end

