%Andrew Burt - a.burt@ucl.ac.uk

function [inputs] = optInputs(cname,dNNz1,dNNz2)
	inputs = struct([]);
	%variation in considered pd1 patch sizes: 150-300% dNNz1
	pd1 = round(prctile(dNNz1,75),3); 
	pd1Steps = 4;
	pd1Start = pd1 * 1.5;
	pd1End = pd1 * 3.0;
	pd1Int =  (pd1End - pd1Start) / (pd1Steps-1);
	%
	%variation in considered pd2 patch sizes: 150-300% dNNz2
	pd2Min = round(prctile(dNNz2,25),3);
	pd2Max = round(prctile(dNNz2,75),3);
	pd2Steps = 6;
	%
	pd2MinStart = pd2Min * 1.5;
	pd2MinEnd = pd2Min * 3.0;
	pd2MinInt = (pd2MinEnd - pd2MinStart) / (pd2Steps-1);
	%
	pd2MaxStart = pd2Max * 1.5;
	pd2MaxEnd = pd2Max * 3.0;
	pd2MaxInt = (pd2MaxEnd - pd2MaxStart) / (pd2Steps-1);
	%lcyl values
	lcyl = [3;5];
	%filrad values
	filrad = [3.5];
	%iterations per param set
	N = 5;
	i = 1;
	for j = pd1Start : pd1Int : pd1End
		for k = pd2MinStart : pd2MinInt : pd2MinEnd
			for l = pd2MaxStart : pd2MaxInt : pd2MaxEnd
				for m = 1:length(lcyl)
					for n = 1:length(filrad)
						for p = 1:N   
							input.PatchDiam1 = j;
							input.PatchDiam2Min = k;
							input.PatchDiam2Max = l;
							input.lcyl = lcyl(m);
							input.FilRad = filrad(n);
							input.BallRad1 = j + 0.02; %* 1.1;
							input.BallRad2 = l + 0.01; %* 1.1;
							input.nmin1 = 3;
							input.nmin2 = 1;
							input.OnlyTree = 1;
							input.Tria = 0;
							input.Dist = 1;
							input.MinCylRad = 0;
							input.ParentCor = 0;
							input.TaperCor = 0;
							input.GrowthVolCor = 1;
							input.GrowthVolFac = 2.5;
							tmp1 = strsplit(char(cname),'/');
							tmp2 = strsplit(char(tmp1(length(tmp1))),'.');
							mname = char(strcat(tmp2(1),'-',num2str(i))); 
							input.name = mname;
							input.tree = 1;
							input.model = i;
							input.savemat = 1;
							input.savetxt = 0;
							input.plot = 0;
							input.disp = 0;
							inputs = [inputs, input];
							i = i+1;
						end
					end
				end
			end
		end
	end
end
