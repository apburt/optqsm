%Andrew Burt - a.burt@ucl.ac.uk

function [] = dispInputs(inputs)
	cname = strsplit(inputs(1).name,'-');
	disp('TreeID:');
	disp(cname{1});
	disp('PatchDiam1 range:');
	disp(unique([inputs.PatchDiam1]));
	disp('PatchDiam2Min range:');
	disp(unique([inputs.PatchDiam2Min]));
	disp('PatchDiam2Max range:');
	disp(unique([inputs.PatchDiam2Max]));
	disp('lcyl range:');
	disp(unique([inputs.lcyl]));
	disp('FilRad range:');
	disp(unique([inputs.FilRad]));
	disp('N per param set:');
	disp(length(inputs)/(length(unique([inputs.PatchDiam1]))*length(unique([inputs.PatchDiam2Min]))*length(unique([inputs.PatchDiam2Max]))*length(unique([inputs.lcyl]))));
	disp('QSMs to be constructed (may be less after invalid param sets are pruned): ');
	disp(length(inputs));
end
