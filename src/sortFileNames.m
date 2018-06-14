%Andrew Burt - a.burt@ucl.ac.uk

function [directory,fnames,uniquenames,plotname] = sortFileNames(single_string_path)
	files = dir(single_string_path);
	[token,remain] = strtok(fliplr(single_string_path),'/');
	directory = fliplr(remain);
	fnames = {};
	count = 1;
	for i = 1:length(files) %!
		fnames(count) = {[directory files(i).name]};
		count = count + 1;
	end
	names = {};
	plotname = '';
	for j = 1:length(fnames)
		tmp1 = strsplit(char(fnames(j)),'/');
		tmp2 = strsplit(char(tmp1(length(tmp1))),'-');
		tmp3 = strsplit(char(tmp2(1)),'.');
		names(j) = {char(tmp3(1))};
		if j==1
			tmp4 = strsplit(char(tmp2(1)),'_');
			plotname = char(tmp4(1));
		end
	end
	uniquenames = unique(names);
end
