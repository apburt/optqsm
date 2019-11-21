%Andrew Burt - a.burt@ucl.ac.uk

function [inputs] = singleInput(cname,dNNz1,dNNz2)
	inputs = struct([]);
	lcyl = 6;
	filrad = 3.0;
	N = 10;
	for i=1:N
		input.PatchDiam1 = round(prctile(dNNz1,100),3) * 1.0 * 2.0;
		input.PatchDiam2Min = round(prctile(dNNz2,0),3) * 1.0 * 2.0;
		input.PatchDiam2Max = round(prctile(dNNz2,100),3) * 1.0 * 2.0;
		input.lcyl = lcyl;
		input.FilRad = filrad;
		input.BallRad1 = round(prctile(dNNz1,100),3) * 1.1 * 2.0;
		input.BallRad2 = round(prctile(dNNz2,100),3) * 1.1 * 2.0;
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
