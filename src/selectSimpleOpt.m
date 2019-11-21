%Andrew Burt - a.burt@ucl.ac.uk

function [vol,stddev] = selectSimpleOpt(qsms,savename)
	inputs = zeros(length(qsms),5);
	for i = 1:length(qsms)
		inputs(i,:) = [qsms(i).rundata.inputs.PatchDiam1 qsms(i).rundata.inputs.PatchDiam2Min ...
			qsms(i).rundata.inputs.PatchDiam2Max qsms(i).rundata.inputs.lcyl ...
			qsms(i).rundata.inputs.FilRad];
	end
	oidxs = [];
	uidx = 1;
	uinputs = unique(inputs,'rows');
	oidxs = 1:1:length(qsms);
	volumes = zeros(length(oidxs),1);
	optmodels = {};
	for i = 1:length(oidxs)
		volumes(i,1) = qsms(oidxs(i)).treedata.TotalVolume;
		optmodels{i} = qsms(oidxs(i)).rundata.inputs.name;
	end
	[~,oidx] = min(abs(volumes - mean(volumes)));
	qsm = qsms(oidxs(oidx));
	vol = mean(volumes);
	stddev = std(volumes);
	vresults = [vol,stddev];
	qsm.optimisation = struct();
	qsm.optimisation.optmodels = optmodels;
	qsm.optimisation.vol = vol;
	qsm.optimisation.volstd = stddev;
	disp(savename);
	disp('Opt params:');
	disp(uinputs(uidx,:));
	disp('Volume, sigma:');
	disp(vresults);
	save(savename,'qsm');
