%Andrew Burt - a.burt@ucl.ac.uk

function [vol,stddev] = selectFullOpt(qsms,optimisation_type,savename)
	inputs = zeros(length(qsms),5);
	for i = 1:length(qsms)
		inputs(i,:) = [qsms(i).rundata.inputs.PatchDiam1 qsms(i).rundata.inputs.PatchDiam2Min ...
			qsms(i).rundata.inputs.PatchDiam2Max qsms(i).rundata.inputs.lcyl ...
			qsms(i).rundata.inputs.FilRad];
	end
	oidxs = [];
	uidx = 1;
	uinputs = unique(inputs,'rows');
       	if optimisation_type == "simple"
		oidxs = 1:1:length(qsms);
	elseif optimisation_type == "full"
		results = zeros(length(uinputs),3);
		for i = 1:length(uinputs)
			tmp = [];
			count = 1;
			for j = 1:length(inputs)
			       if isequal(inputs(j,:),uinputs(i,:))
					tmp(count,1) = qsms(j).pmdistance.mean;
					tmp(count,2) = qsms(j).pmdistance.median;
					tmp(count,3) = qsms(j).pmdistance.std;
					count = count + 1;
			       end
			end
			results(i,1) = mean(tmp(:,1));
			results(i,2) = mean(tmp(:,2));
			results(i,3) = mean(tmp(:,3));
		end
		[~,uidx] = min(results(:,1));
		count = 1;
		for i = 1:length(inputs)
			if isequal(inputs(i,:),uinputs(uidx,:))
				oidxs(count,1) = i;
				count = count + 1;
			end
		end
	end
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
	disp(savename);
	disp('Opt params:');
	disp(uinputs(uidx,:));
	disp('Volume, sigma:');
	disp(vresults);
	save(savename,'qsm','optmodels','vresults');
%	inputs = zeros(length(qsms),5);
%	for i = 1:length(qsms)
%		inputs(i,:) = [qsms(i).rundata.inputs.PatchDiam1 qsms(i).rundata.inputs.PatchDiam2Min ...
%				qsms(i).rundata.inputs.PatchDiam2Max qsms(i).rundata.inputs.lcyl ...
%				qsms(i).rundata.inputs.FilRad];
%	end
%	TRUNK_POSITIONS = [0.1,0.2,0.3,0.4,0.5];
%	qsmcount = 1;
%	uinputs = unique(inputs,'rows');
%	rad = zeros(length(uinputs),length(TRUNK_POSITIONS));
%	for i = 1:length(uinputs)
%		r_tmp = [];
%		qsmcount = 1;
%		for j = 1:length(inputs)
%			if isequal(inputs(j,:),uinputs(i,:))
%				len = 0;
%				poscount = 1;
%				for k = 1:length(qsms(j).cylinder.radius)
%					if qsms(j).cylinder.BranchOrder(k) == 0
%						len = len + qsms(j).cylinder.length(k);
%					end
%					if len > qsms(j).treedata.TrunkLength * TRUNK_POSITIONS(poscount)
%						r_tmp(qsmcount,poscount) = qsms(j).cylinder.radius(k);
%						poscount = poscount + 1;
%					end
%					if poscount == length(TRUNK_POSITIONS)+1
%						break;
%					end
%				end
%				qsmcount = qsmcount + 1;
%			end
%		end
%		r_tmp = mean(r_tmp);
%		rad(i,:) = r_tmp;
%	end
%	dresults = zeros(length(uinputs),1);
%	for i = 1:length(uinputs)
%		ddiff = mean((max(rad)-rad(i,:))./max(rad));
%		if ddiff <= 0.1
%			qsmcount = 1;
%			tmp = [];
%			for j = 1:length(inputs)
%				if isequal(inputs(j,:),uinputs(i,:))
%					tmp(qsmcount,1) = qsms(j).pmdistance.std;
%					qsmcount = qsmcount + 1;
%				end
%			end
%			dresults(i,1) = mean(tmp);
%		else
%			dresults(i,1) = nan;
%		end
%	end
%	[~,uidx] = nanmin(dresults(:,1));
end
