%Andrew Burt - a.burt@ucl.ac.uk

function [vol,stddev] = selectOpt(qsms,savename)
	inputs = zeros(length(qsms),5);
	for i = 1:length(qsms)
		inputs(i,:) = [qsms(i).rundata.inputs.PatchDiam1 qsms(i).rundata.inputs.PatchDiam2Min ...
				 qsms(i).rundata.inputs.PatchDiam2Max qsms(i).rundata.inputs.lcyl ...
                 qsms(i).rundata.inputs.FilRad];
    end
    uinputs = unique(inputs,'rows');
	dresults = zeros(length(uinputs),20);
	for i = 1:length(uinputs)
		rtmp = zeros(1,20);
		j = 1;
		for k = 1:length(inputs)
			if(isequal(inputs(k,:),uinputs(i,:)))
                rtmp(j,1) = qsms(k).pmdistance.median;
                rtmp(j,2) = qsms(k).pmdistance.mean;
                rtmp(j,3) = qsms(k).pmdistance.max;
                rtmp(j,4) = qsms(k).pmdistance.std;
                rtmp(j,5) = qsms(k).pmdistance.TrunkMedian;
                rtmp(j,6) = qsms(k).pmdistance.TrunkMean;
                rtmp(j,7) = qsms(k).pmdistance.TrunkMax;
                rtmp(j,8) = qsms(k).pmdistance.TrunkStd;
                rtmp(j,9) = qsms(k).pmdistance.BranchMedian;
                rtmp(j,10) = qsms(k).pmdistance.BranchMean;
                rtmp(j,11) = qsms(k).pmdistance.BranchMax;
                rtmp(j,12) = qsms(k).pmdistance.BranchStd;
                rtmp(j,13) = qsms(k).pmdistance.Branch1Median;
                rtmp(j,14) = qsms(k).pmdistance.Branch1Mean;
                rtmp(j,15) = qsms(k).pmdistance.Branch1Max;
                rtmp(j,16) = qsms(k).pmdistance.Branch1Std;
                rtmp(j,17) = qsms(k).pmdistance.Branch2Median;
                rtmp(j,18) = qsms(k).pmdistance.Branch2Mean;
                rtmp(j,19) = qsms(k).pmdistance.Branch2Max;
                rtmp(j,20) = qsms(k).pmdistance.Branch2Std;
				j = j + 1;
            end
        end
		dresults(i,:) = mean(rtmp);
    end
    %[~,uidx] = min((mean(normc(dresults),2)));
    [~,uidx] = min(dresults(:,4));
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
