%Andrew Burt - a.burt@ucl.ac.uk

function [inputs] = singleInput(cname,dNNz1,dNNz2)
	inputs = struct([]);
	pd1 = round(prctile(dNNz1,75),3) * 4;
	pd2Min = round(prctile(dNNz2,25),3) * 4;
	pd2Max = round(prctile(dNNz2,75),3) * 4;
	lcyl = 6;
	filrad = 3.5;
	N = 10;
	for i=1:N
		input.PatchDiam1 = pd1;
		input.PatchDiam2Min = pd2Min;
		input.PatchDiam2Max = pd2Max;
		input.lcyl = lcyl;
		input.FilRad = filrad;
		input.BallRad1 = pd1 * 1.1;%+ 0.02;
		input.BallRad2 = pd2Max * 1.1;% + 0.01;
		input.nmin1 = 3;
		input.nmin2 = 1;
		input.OnlyTree = 1;
		input.Tria = 0;
		input.Dist = 0;
		input.MinCylRad = 0.0025;
		input.ParentCor = 1;
		input.TaperCor = 1;
		input.GrowthVolCor = 0;
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
	end
end
