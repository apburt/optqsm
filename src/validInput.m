%Andrew Burt - a.burt@ucl.ac.uk

function valid = validInput(input)
	valid = false;
	if input.PatchDiam2Max > input.PatchDiam2Min
		if input.PatchDiam1 > input.PatchDiam2Max
			valid = true;
		end
	end
end
