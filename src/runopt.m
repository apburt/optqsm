%Andrew Burt - a.burt@ucl.ac.uk

function [] = runopt(SINGLE_PATH_TO_MODELS)
	[directory,~,uniquenames,plotname] = sortFileNames(SINGLE_PATH_TO_MODELS);
	results = struct('lid',{},'vol',{},'stddev',{});
	for i = 1:length(uniquenames)
		qsms = struct('cylinder',{},'branch',{},'treedata',{},'rundata',{},'pmdistance',{},'triangulation',{});
		modelnames = dir([directory char(uniquenames(i)) '-*.mat']);
		for j = 1:length(modelnames)
			model = load([directory modelnames(j).name]);
			qsms(j) = model.qsm;
        end
        [vol,stddev] = selectOpt(qsms,char(uniquenames(i)));
		results(i).lid = char(uniquenames(i));
		results(i).vol = vol;
		results(i).stddev = stddev;
    end
    fileID = fopen([plotname '_models.dat'],'w');
    for k = 1:length(results)
        fprintf(fileID,'%s %.6f %.6f\n',results(k).lid,results(k).vol,results(k).stddev);
    end
    fclose(fileID);
end
