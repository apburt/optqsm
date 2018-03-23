% Andrew Burt - a.burt@ucl.ac.uk

function [] = runqsm(SINGLE_PATH_TO_CLOUDS,workers)
    MAX_ITER_PER_POOL = 100;
	[~,fnames,~] = sortFileNames(SINGLE_PATH_TO_CLOUDS);
	for i=1:length(fnames)
		cloud = load(char(fnames(i)));
		dNNz1 = dNNz(cloud,3,2.5);       
		dNNz2 = dNNz(cloud,1,2.5);
		inputs = optInputs(fnames(i),dNNz1,dNNz2);
		dispInputs(inputs);
		if workers == 1
			for j=1:length(inputs)
				if validInput(inputs(j)) == true
					if exist(strcat(inputs(j).name,'.mat'),'file') == 0
						treeqsm_mod(cloud,inputs(j));
					end
				end
			end
		elseif workers > 1
            %this is required due to memory leak and pool irregularly going stale
            for j=1:MAX_ITER_PER_POOL:(length(inputs)+MAX_ITER_PER_POOL)
                P = openParPool(workers);
                parfor k=j:j+MAX_ITER_PER_POOL
                    if k <= length(inputs)
                        if validInput(inputs(k)) == true
                            if exist(strcat(inputs(k).name,'.mat'),'file') == 0
                                treeqsm_mod(cloud,inputs(k));
                            end
                        end
                    end
                end
                delete(P);
            end
        end
	end
end