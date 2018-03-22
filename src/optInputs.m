% Andrew Burt - a.burt@ucl.ac.uk

function [inputs] = optInputs(cname,dNNz1,dNNz2)
    inputs = struct([]);
    %variation in considered patch sizes: 75-125%
    pd1 = round(max(dNNz1),3); 
    pd1Steps = 5;
    pd1Start = pd1 * 0.75;
    pd1End = pd1 * 1.25;
    pd1Int =  (pd1End - pd1Start) / (pd1Steps-1);
    %
    pd2Min = round(min(dNNz2),3);
    pd2Max = round(max(dNNz2),3);
    pd2Steps = 5;
    %
    pd2MinStart = pd2Min * 0.75;
    pd2MinEnd = pd2Min * 1.25;
    pd2MinInt = (pd2MinEnd - pd2MinStart) / (pd2Steps-1);
    %
    pd2MaxStart = pd2Max * 0.75;
    pd2MaxEnd = pd2Max * 1.5;
    pd2MaxInt = (pd2MaxEnd - pd2MaxStart) / (pd2Steps-1);
    %lcyl values
    lcyl = [3;4;5];
    %iterations per param set
    N = 5;
    i = 1;
    for j = pd1Start : pd1Int : pd1End
        for k = pd2MinStart : pd2MinInt : pd2MinEnd
            for l = pd2MaxStart : pd2MaxInt : pd2MaxEnd
                for m = 1:length(lcyl)
                    for n = 1:N   
                        input.PatchDiam1 = j;
                        input.PatchDiam2Min = k;
                        input.PatchDiam2Max = l;
                        input.lcyl = lcyl(m);
                        input.FilRad = 3.5;
                        input.BallRad1 = j + (j * 0.1);
                        input.BallRad2 = l + (l * 1.1);
                        input.nmin1 = 3;
                        input.nmin2 = 1;
                        input.OnlyTree = 1;
                        input.Tria = 0;
                        input.Dist = 1;
                        input.MinCylRad = 0.0025;
                        input.ParentCor = 1;
                        input.TaperCor = 1;
                        input.GrowthVolCor = 0;
                        input.GrowthVolFrac = 2.5;
                        tmp1 = strsplit(char(cname),'/');
                        tmp2 = strsplit(char(tmp1(length(tmp1))),'.');
                        mname = char(strcat(tmp2(1),'-',num2str(i))); 
                        input.name = mname;
                        input.tree = 1;
                        input.model = i;%N;
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

