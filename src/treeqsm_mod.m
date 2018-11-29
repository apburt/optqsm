% This file is part of TREEQSM.
% 
% TREEQSM is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% TREEQSM is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with TREEQSM.  If not, see <http://www.gnu.org/licenses/>.
%
% Copyright (C) 2013-2017 Pasi Raumonen

function [] = treeqsm_mod(P,inputs,mdir)
	% ---------------------------------------------------------------------
	% treeqsm_mod.M     Version of treeqsm.m modified for optqsm
	%                   Andrew Burt - a.burt@ucl.ac.uk
	% ---------------------------------------------------------------------
	rng('shuffle');
	cover1 = cover_sets(P,inputs);
	[cover1,Base,Forb] = tree_sets(P,cover1,inputs);
	segment1 = segments(cover1,Base,Forb);
	segment1 = correct_segments(P,cover1,segment1,inputs,0,1,1);
	RS = relative_size(P,cover1,segment1);
	cover2 = cover_sets(P,inputs,RS);
	[cover2,Base,Forb] = tree_sets(P,cover2,inputs,segment1);
	segment2 = segments(cover2,Base,Forb);
	segment2 = correct_segments(P,cover2,segment2,inputs,1,1,0);
	cylinder = cylinders(P,cover2,segment2,inputs);
	if ~isempty(cylinder.radius)
		[branch,cylinder] = branches(segment2,cylinder);
		T = segment2.segments{1};
		T = vertcat(T{:});
		T = vertcat(cover2.ball{T});
		trunk = P(T,:);
		[treedata,triangulation] = tree_data(cylinder,branch,inputs,trunk,0);
		if inputs.Dist
			pmdis = point_model_distance(P,cylinder);
		end
		Date(2,:) = clock;
		qsm = struct('cylinder',{},'branch',{},'treedata',{},'rundata',{},'pmdistance',{},'triangulation',{});
		qsm(1).cylinder = cylinder;
		qsm(1).branch = branch;
		qsm(1).treedata = treedata;
		qsm(1).rundata.inputs = inputs;
		qsm(1).rundata.date = single(Date);
		if inputs.Dist
			qsm(1).pmdistance = pmdis;
		end
		if inputs.Tria
			qsm(1).triangulation = triangulation;
		end
		save(strcat(mdir,[inputs.name]),'qsm');
	end
end
