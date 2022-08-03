# HOEDMD Code

## Core Algorithms
Implementation of core algorithms (HOEDMD-STLS, HOEDMD-NONSVD and HOEDMD-KER) has been put under `algs` folder. We also implement HODMD algorithm as `hodmd_v3.m`.

``` bash
(base) ➜ HOEDMD tree algs                       
algs
├── hodmd_v3.m
├── hoedmd_ker.m
├── hoedmd_stls.m
└── kermthd
    ├── ker_vec.m
    ├── kerprod.m
    └── opt_solve.m
```

## Multilinear PageRank
The following code indicates how to reproduce the results in the multilinear pagerank example and visualize it.

``` matlab
addpath(genpath('./algs'))
addpath('./utils')
addpath(genpath('./multi-pr'))
cd './multi-pr'
% generate hoedmd results
clc;clear;
% set N = 50; M = 2; in the 1st line in main.m and main_plot.m
main
main_plot
```

## Time series classification
The following code indicates how to reproduce the results in the time series classification example and analyze it. 
**Data-Preprocess Notes**: Please navigate to [BasicMotions](http://www.timeseriesclassification.com/description.php?Dataset=BasicMotions) to download the dataset and preprocess each sample into `mat` format. Edit files' location information in the config file `clus_cfgs.mat`.
To apply DMD on time series
``` matlab
addpath(genpath('./algs'))
addpath('./utils')
addpath(genpath('./ucr'))
cd './ucr/cluster'
bm_ker_vap_p
```

The DMD results will generate under the `data/hoedmd/BM`, then you can run the `cluster` with `elbow`.

``` matlab
run_cluster_ker
```

You can analyze the results by visualize `elbow_table_ker`. Each column represents Accuracy (ACC), Sensitivity (SEN), and Specificity (SPE); Each row represents `p` performance from `10` to `90` under the `S = 10`.

## fMRI data 

**Data-Preprocess Notes**:Data used in this section were provided by the [Human Connectome Project](https://db.humanconnectome.org/), WU-Minn Consortium. We randomly select one subject and apply DMD variants to his/her fMRI signal, which is saved in [fmri_table](fmri/data/fmri_table.mat). We replace the file with a random matrix for the consideration of HCP data license, so please replace the file with the fMRI data downloaded from HCP when reproducing the example.

To generate DMD-variants results, you should install `PyDMD` as [PyDMD Project](https://github.com/mathLab/PyDMD) Indicates.

``` bash
python main_dmd.py
```

It will generate `DMD_dict.mat` in the folder.

``` matlab
addpath(genpath('./algs'))
addpath('./utils')
addpath(genpath('./fmridmd'))
cd './fmridmd'
gd_hoedmd
```

You can view the visulization by `boxchart`

``` matlab
boxchart(abs(real(log(eigs_table_S1))))
boxchart(abs(real(log(eigs_table_S2))))
```