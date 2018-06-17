%Andrew Burt - a.burt@ucl.ac.uk

function [vol,stddev] = selectOpt(qsms,savename)
	inputs = zeros(length(qsms),5);
	for i = 1:length(qsms)
		inputs(i,:) = [qsms(i).rundata.inputs.PatchDiam1 qsms(i).rundata.inputs.PatchDiam2Min ...
				 qsms(i).rundata.inputs.PatchDiam2Max qsms(i).rundata.inputs.lcyl ...
                 qsms(i).rundata.inputs.FilRad];
	end
	uinputs = unique(inputs,'rows');
	dresults = zeros(length(uinputs),7);
	for i = 1:length(uinputs)
		rtmp = zeros(1,6);
		j = 1;
		for k = 1:length(inputs)
			if(isequal(inputs(k,:),uinputs(i,:)))
				rtmp(j,1) = qsms(k).pmdistance.TrunkMean;
				rtmp(j,2) = qsms(k).pmdistance.TrunkStd;
				rtmp(j,3) = rtmp(j,2) / rtmp(j,1);
				rtmp(j,4) = qsms(k).pmdistance.Branch1Mean;
				rtmp(j,5) = qsms(k).pmdistance.Branch1Std;
				rtmp(j,6) = rtmp(j,5) / rtmp(j,4);
				rtmp(j,7) = (rtmp(j,3) + rtmp(j,6))/2;
				j = j + 1;
			end
		end
		dresults(i,:) = mean(rtmp);
	end
	[~,uidx] = min(dresults(:,1));
	oidxs = zeros(1,1);
	j = 1;
	for i = 1:length(inputs)
		if(isequal(inputs(i,:),uinputs(uidx,:)))
			oidxs(j,1) = i;
			j = j+1;
		end
	end
	dists = zeros(length(oidxs),1);
	volumes = zeros(length(oidxs),1);
	optmodels = cell(length(oidxs),1);
	for i = 1:length(oidxs)
		dists(i,1) = qsms(oidxs(i)).pmdistance.TrunkMean;
		volumes(i,1) = qsms(oidxs(i)).treedata.TotalVolume;
		optmodels{i} = qsms(oidxs(i)).rundata.inputs.name;
	end
	[~,oidx] = min(dists);
	qsm = qsms(oidxs(oidx));
	vol = mean(volumes);
	stddev = std(volumes);
	vresults = [vol,stddev];
	disp(savename);
	disp('Opt params:');
	disp(uinputs(uidx,:));
	disp('Volume, sigma:');
	disp(vresults);
	save(savename,'qsm','optmodels','vresults');
end
