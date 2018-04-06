%Andrew Burt - a.burt@ucl.ac.uk

function [] = runqsm(SINGLE_PATH_TO_CLOUDS,workers)
	MAX_ITER_PER_POOL = 250;
	MAX_TIME_PER_ITER = 60*60*5;
	[~,fnames,~,~] = sortFileNames(SINGLE_PATH_TO_CLOUDS);
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
			for j=1:MAX_ITER_PER_POOL:(length(inputs)+MAX_ITER_PER_POOL)
				vInputs = struct([]);
				for k=j:j+MAX_ITER_PER_POOL-1
					if k <= length(inputs)
						if validInput(inputs(k)) == true
							if exist(strcat(inputs(k).name,'.mat'),'file') == 0
								vInputs = [vInputs,inputs(k)];
							end
						end
					end
				end
				if length(vInputs) > 0
					pool = openParPool(workers);
					for m=1:length(vInputs)
						futures(m) = parfeval(pool,@treeqsm_mod,0,cloud,vInputs(m));
					end
					wait(futures,'finished',MAX_TIME_PER_ITER);
					delete(pool);	
				end
			end
		end
	end
end
