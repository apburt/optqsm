%Andrew Burt - a.burt@ucl.ac.uk

function [nndata] = dNNz(cloud,nnearest,zstep)
	nndata = [];
	mind = min(cloud);
	maxd = max(cloud);
	for i = mind(3) : zstep : maxd(3)
		zslice = NaN(length(cloud),3);
		for j = 1 : length(cloud)
			if cloud(j,3) >= i && cloud(j,3) < i+zstep
				zslice(j,:) = cloud(j,:);
			end
		end
		zslice(~any(~isnan(zslice),2),:)=[];
		nn = dNN(zslice,nnearest);
		nndata = [nndata; nn];
	end
end
