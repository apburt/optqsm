%Andrew Burt - a.burt@ucl.ac.uk

function [] = runopt(SINGLE_PATH_TO_MODELS)
	[directory,~,uniquenames] = sortFileNames(SINGLE_PATH_TO_MODELS);
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
