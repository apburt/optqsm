% Andrew Burt - a.burt@ucl.ac.uk

function [directory,fnames,uniquenames] = sortFileNames(single_string_path)
	files = dir(single_string_path);
	[token,remain] = strtok(fliplr(single_string_path),'/');
	directory = fliplr(remain);
	fnames = {};
	for i = 1:length(files)
		fnames(i) = {[directory files(i).name]};
	end
	names = {};
	for j = 1:length(fnames)
		tmp1 = strsplit(char(fnames(j)),'/');
		tmp2 = strsplit(char(tmp1(length(tmp1))),'-');
		tmp3 = strsplit(char(tmp2(1)),'.');
		names(j) = {char(tmp3(1))};
	end
	uniquenames = unique(names);
end
