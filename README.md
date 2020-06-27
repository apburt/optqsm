# optqsm

Automatically optimise and parallelise TreeQSM: a method for constructing structural models of trees from lidar point clouds

## Overview

optqsm wraps around TreeQSM to fully automate the construction of quantitative structural models (QSMs) from individual tree point clouds.
optqsm can also be used to locally parallelise TreeQSM.

optqsm automatically selects TreeQSM input parameters by analysing the vertically-resolved nearest neighbour distances across the input point cloud.
The expectation of the input point cloud is that it provides a reasonably complete sample of the underlying tree surface, with minimal occlusion effects.
It is also expected that the point cloud contains only returns from woody surfaces; for segmenting leaf returns consider using TLSeparation (https://github.com/TLSeparation).

## Dependencies

MATLAB vR2019b with Statistics and Machine Learning and Parallel Computing toolboxes <br />
TreeQSM v2.3.2 (https://github.com/InverseTampere/TreeQSM)

## Installation

TreeQSM v2.3.2 can be installed via: 

```
cd [INSTALLATION_DIR];
git clone https://github.com/InverseTampere/TreeQSM.git;
cd TreeQSM;
git checkout tags/v.2.3.2;
```

* If cubic metre is preferred as the output unit of volume, lines 74--76 of [INSTALLATION_DIR]/TreeQSM/src/main_steps/tree_data.m require removal of the 1000x entries.

optqsm can then be installed as:

```
cd [INSTALLATION_DIR];
git clone https://github.com/apburt/optqsm.git;
```

The paths to both TreeQSM and optqsm require setting in MATLAB, i.e.,:

```
matlab -nodisplay;
addpath(genpath('[INSTALLATION_DIR]/TreeQSM/src/'));
addpath('[INSTALLATION_DIR]/optqsm/src/');
savepath();
```

If the user does not have sufficient privileges to call savepath(...), these addpath(...) calls will be required at the beginning of each MATLAB instance.

## Usage

The input to optqsm are the paths (wildcards permitted) to N tree-level point clouds (ASCII, 3-column (x,y,z), no header). 
The example here uses the following file structure:

```
[PROCESSING_DIR]
├───clouds
│   ├───plot1_1.txt
│   ├───plot1_...txt
│   ├───plot1_N.txt
└───models
    ├───intermediate
```

Where the naming of each point cloud strictly follows: [PLOT_ID]_[TREE_ID].txt.

The runqsm function can then be called from the command line as:

```
cd [PROCESSING_DIR]/models/intermediate/;
matlab -nodisplay -r "runqsm('../../clouds/*.txt',workers)";
```

This command will calculate the vertically-resolved nearest neighbour distance for each point cloud, and estimate the optimum values of PatchDiam1, PatchDiam2Min, PatchDiam2Max, BallRad1 and BallRad2.
These parameter sets will then be used to construct 10 QSMs for each point cloud.

Workers is an integer specifying the number of workers in the local parallel pool that will be initialised if > 1.

The optqsm function can then be called as:

```
cd ../;
matlab -nodisplay -r "runopt('./intermediate/*/*.mat')";
```

Which will return plot1_1.mat ... plot1_N.mat, and plot1.dat  
The .dat file reports the mean volume and standard deviation across the 10 QSMs generated from each input point cloud. 
The .mat files are the QSM in each set of 10 whose volume was closest to the mean volume. 

The definition of parameters inside the .mat files can be found in [INSTALLATION_DIR]/TreeQSM/src/treeqsm.m. 
They can be interacted with outside MATLAB, e.g., in Python with scipy.io.loadmat() (although care is required with MATLAB not using zero-based arrays). 

## Authors

* **Andrew Burt**

## License

optqsm is licensed under the MIT License - see the [LICENSE](LICENSE) file for details 

## Acknowledgements

optqsm uses TreeQSM (https://github.com/InverseTampere/TreeQSM)
