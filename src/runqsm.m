% Andrew Burt - a.burt@ucl.ac.uk

function [] = runqsm(single_string_path_to_clouds,workers)
	[directory,fnames,uniquenames] = sortFileNames(single_string_path_to_clouds);
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
			%opening pool here rather than at top as irregularly goes stale
			openParPool(workers);
			parfor j=1:length(inputs)
				if validInput(inputs(j)) == true
					if exist(strcat(inputs(j).name,'.mat'),'file') == 0
						treeqsm_mod(cloud,inputs(j));
					end
				end
			end
			delete(gcp('nocreate'));
        	end
	end
end
