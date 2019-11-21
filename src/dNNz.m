%Andrew Burt - a.burt@ucl.ac.uk

function [nndata] = dNNz(cloud,nnearest,steps)
	nndata = [];
	z_min = min(cloud(:,3));
	z_max = max(cloud(:,3));
	height = z_max - z_min;
	z_delta  = height / steps;
	for i = z_min : z_delta : z_max - z_delta
		zslice = NaN(length(cloud),3);
		for j = 1 : length(cloud)
			if cloud(j,3) >= i && cloud(j,3) < i+z_delta
				zslice(j,:) = cloud(j,:);
			end
		end
		zslice(~any(~isnan(zslice),2),:)=[];
		nn = dNN(zslice,nnearest);
		nndata = [nndata; nn];
	end
end
