# optqsm

Automatically optimise and parallelise TreeQSM: a method for constructing structural models of trees from lidar point clouds

## Overview

optqsm wraps around TreeQSM to fully-automate (via nearest neighbour analysis) the construction and optimisation of QSMs.
optqsm can also be used to locally parallelise the construction of QSMs. 

## Dependencies

MATLAB vR2018b with Statistics and Machine Learning (v11.4) and Parallel Computing (v6.13) toolboxes <br />
TreeQSM v2.30 (https://github.com/InverseTampere/TreeQSM)

## Installation

With MATLAB installed, TreeQSM can be installed via: 

```
cd [INSTALLATION_DIR];
git clone https://github.com/InverseTampere/TreeQSM.git;
```

The following modifications are required to [INSTALLATION_DIR]/TreeQSM/src/main_steps/tree_data.m
* Line 258--306 require commenting out.
* If cubic metre is preferred as the output unit of volume, lines 59--61 require removal of 1000x.

optqsm can then be installed as:

```
git clone https://github.com/apburt/optqsm.git;
```

The paths to both TreeQSM and optqsm must then be set in MATLAB, e.g.,:

```
matlab -nodisplay;
addpath(genpath('[INSTALLATION_DIR]/TreeQSM/src/'));
addpath('[INSTALLATION_DIR]/optqsm/src/');
savepath();
```

If the user does not have sufficient privileges to call savepath(...), then addpath(...) is required at the beginning of each instance (as shown below).

## Usage

Input to optqsm are the paths to N tree-level point clouds (ASCII, 3-column (x,y,z), no header) in the following file structure:

```
[PROC_DIR]
├───clouds
│   ├───plot1_1.txt
│   ├───plot1_2.txt
│   ├───plot1_....
└───models
    ├───intermediate
```

With the naming convention of each point cloud following [PLOT_ID]_[TREE_ID].txt.
optqsm can then be called from the command line as:

```
cd [PROC_DIR]/models/intermediate/;
matlab -nodisplay -r "runqsm('../clouds/*.txt',workers)";
cd ../;
matlab -nodisplay -r "runopt('./intermediate/*.mat')";
```

Where workers is an integer specifying the number of workers in the local parallel pool that is initialised if greater than 1.

When run as above, each .mat inside [PROCESSING DIR]/models/ contains the optimised QSM + supplementary data per tree.
The definition of parameters inside this .mat can be found in TreeQSM/src/treeqsm.m.
This .mat can be interacted with outside MATLAB, e.g., in Python with scipy.io.loadmat() (although care is required with MATLAB not using zero-based arrays).

By default, optqsm samples the parameter space (PatchDiam1,PatchDiam2Min,PatchDiam2Max,lcyl) defined in optqsm/src/optInputs.m, constructing ~7500 models per tree (minus any invalid parameter sets).
These values have been shown across various data to capture most of the valid parameter space, but can be readily modified to increase/reduce computation.

If it not possible to permanently set the MATLAB path, the two calls to MATLAB must be modified as:

```
matlab -nodisplay -r "addpath(genpath('[INSTALLATION_DIR]/TreeQSM/src/'));addpath('[INSTALLATION_DIR]/optqsm/src/');runqsm('../clouds/*.txt',workers)";
matlab -nodisplay -r "addpath(genpath('[INSTALLATION_DIR]/TreeQSM/src/'));addpath('[INSTALLATION_DIR]/optqsm/src/');runopt('./intermediate/*.mat')";
```

## Authors

* **Andrew Burt**

## License

optqsm is licensed under the MIT License - see the [LICENSE](LICENSE) file for details 

## Acknowledgements

optqsm uses TreeQSM (https://github.com/InverseTampere/TreeQSM)
