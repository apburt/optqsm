% Andrew Burt - a.burt@ucl.ac.uk

function [] = runopt(single_string_path_to_models)
	[directory,fnames,uniquenames] = sortFileNames(single_string_path_to_models);
	for i = 1:length(uniquenames)
		qsm = struct('cylinder',{},'branch',{},'treedata',{},'rundata',{},'pmdistance',{},'triangulation',{});
		modelnames = dir([directory char(uniquenames(i)) '-*.mat']);
		for j = 1:length(modelnames)
			model = load([directory modelnames(j).name]);
			qsm(j) = model.qsm;
		end
		select_optimum_mod(qsm,char(uniquenames(i)));
	end
end
