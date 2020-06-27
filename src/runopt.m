%Andrew Burt - a.burt@ucl.ac.uk

function [] = runopt(WILDCARD_PATH_TO_MODELS)
%function [] = runopt(WILDCARD_PATH_TO_MODELS,optimisation_type)
	results = struct('lid',{},'vol',{},'stddev',{});
	fnames = glob(WILDCARD_PATH_TO_MODELS);
	tmp = {};
	for i=1:length(fnames)
		tmp1 = strsplit(char(fnames(i)),'/');
		tmp2 = strsplit(char(tmp1(length(tmp1))),'-');
		tmp3 = strsplit(char(tmp2(1)),'.');
		tmp(i) = {char(tmp3(1))};
	end
	uniquenames = unique(tmp);
	for i = 1:length(uniquenames)
		qsms = struct('cylinder',{},'branch',{},'treedata',{},'rundata',{},'pmdistance',{},'triangulation',{});
		modelnames = glob(['**',char(uniquenames(i)),'-*.mat']);
		count = 1;
		for j = 1:length(modelnames)
			model = load(char(modelnames(j)));
			if (sum(strcmp(fieldnames(model),'qsm')) == 1)
				qsms(count) = model.qsm;
				count = count + 1;
			end
		end
	        %if optimisation_type == "simple"
			[vol,stddev] = selectSimpleOpt(qsms,char(uniquenames(i)));
    		%elseif optimisation_type == "Full"
		%	[vol,stddev] = selectFullOpt(qsms,optimisation_type,char(uniquenames(i)));
		%end
		results(i).lid = char(uniquenames(i));
		results(i).vol = vol;
		results(i).stddev = stddev;
	end
	tmp = strsplit(char(uniquenames(1)),'_');
	plotname = char(tmp(1));
	fileID = fopen([plotname '_models.dat'],'w');
	for k = 1:length(results)
		fprintf(fileID,'%s %.6f %.6f\n',results(k).lid,results(k).vol,results(k).stddev);
	end
	fclose(fileID);
	exit;
end
