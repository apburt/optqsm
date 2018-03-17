% Andrew Burt - a.burt@ucl.ac.uk

function [] = runqsm(path_to_clouds,workers)
    cloudnames = dir(path_to_clouds);
    for i=1:length(cloudnames)
        cname = [cloudnames(i).folder '/' cloudnames(i).name];
        cloud = load(cname);
        dNNz1 = dNNz(cloud,3,2.5);       
        dNNz2 = dNNz(cloud,1,2.5);
        inputs = optInputs(cname,dNNz1,dNNz2);
        dispInputs(inputs);
        if workers == 1
            for j=1:length(inputs)
                if exist(strcat(inputs(j).name,'.mat'),'file') == 0
                    treeqsm_mod(cloud,inputs(j));
                end
            end
        elseif workers > 1
            %opening pool here rather than at top as irregularly goes stale
            openParPool(workers);
            parfor j=1:length(inputs)
                if exist(strcat(inputs(j).name,'.mat'),'file') == 0
                    treeqsm_mod(cloud,inputs(j));
                end
            end
            delete(gcp('nocreate'));
        end
    end
end

