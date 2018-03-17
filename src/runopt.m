% Andrew Burt - a.burt@ucl.ac.uk

function [] = runopt(path_to_models)
    modelnames = dir(path_to_models);
    tmp1 = strings(length(modelnames),1);
    for i = 1:length(modelnames)
        tmp2 = split(modelnames(i).name,'-');
        tmp1(i) = tmp2{1};
    end
    umodels = unique(tmp1,'row');
    for j = 1:length(umodels)
        %this has the potential to cause carnage
        [token,remain] = strtok(reverse(path_to_models),'/');
        tmp3 = reverse(remain);
        umodelpath = strcat(tmp3,umodels(j)','-*.mat');
        umodelnames = dir(convertStringsToChars(umodelpath));
        %
        qsm = struct('cylinder',{},'branch',{},'treedata',{},'rundata',{},'pmdistance',{},'triangulation',{});
        for k = 1:length(umodelnames)
            mname = [umodelnames(k).folder '/' umodelnames(k).name];
            model = load(mname);
            qsm(k) = model.qsm;
        end
        select_optimum_mod(qsm,umodels(j));
    end
end