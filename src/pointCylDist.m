%Andrew Burt - a.burt@ucl.ac.uk

function dist = pointCylDist(P,cylinder) 
	results = zeros(length(P),1);
	for i=1:length(P)
		p = P(i,:);
		pdist = zeros(length(cylinder.radius),1);
		for j=1:length(cylinder.radius)
			v1 = cylinder.start(j,:);
			v2 = cylinder.start(j,:) + cylinder.axis(j,:) .* cylinder.length(j,:);
			v1 = repmat(v1,size(p,1),1);
			v2 = repmat(v2,size(p,1),1);
			a = v1 - v2;
			b = p - v2;
			pdist(j,1) = sqrt(sum(cross(a,b,2).^2,2)) ./ sqrt(sum(a.^2,2));
		end
		[mpdist,idx] = min(pdist);
		results(i,1) = abs(cylinder.radius(idx)-mpdist);
	end
	dist.mean = mean(results(:,1));
	dist.median = median(results(:,1));
	dist.std = std(results(:,1));
end
