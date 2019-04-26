# coarse-to-fine HS for PIV

### coarse-to-fine variational optical flow method for fluid flows

This project is implemented to perform the multi-resolution HS optical flow computing.  

The Horn & Schunck (HS) method, which is also called variational optical flow, is widely used in the computer vision community. 
In this project, we mainly focus on the application of particle image velocimetry (PIV), which is a motion estimation technique for fluid flows.
<br> 

### Main reference:

	Horn, B. and Schunck, B. (1981) Artificial Intelligent 17:185-203  
	Ruhnau, P., et al. (2005) Experiments in Fluids 38(1):21-32.  
	Heitz, D., et al. (2010) Experiments in Fluids 48(3):369-393.  
	Sun, D., et al. (2010) Computer Vision & Pattern Recognition.  

### License and citation:

This repository is provided for research purposes only. 

The program is the basis of the complex motion estimator for fluid flows: [Motion Estimation under Location Uncertainty for Turbulent Fluid Flow](https://doi.org/10.1007/s00348-017-2458-z). If you use the codes in your research work, please cite the following paper: 
  
	@article{cai2018motion,
  	  title={Motion estimation under location uncertainty for turbulent fluid flows},
  	  author={Cai, Shengze and M{\'e}min, Etienne and D{\'e}rian, Pierre and Xu, Chao},
  	  journal={Experiments in Fluids},
  	  volume={59},
  	  number={1},
  	  pages={8},
  	  year={2018},
  	  publisher={Springer}
	}


### Usage:  Run the script main.m  
  
### Example:

The images of this example are originally provided by FLUID - http://fluid.irisa.fr/data-eng.htm  

![image1](https://github.com/shengzesnail/coarse_to_fine_HS_PIV/blob/master/data/image1.png)
![image2](https://github.com/shengzesnail/coarse_to_fine_HS_PIV/blob/master/data/image2.png)


#### Results - estimated flow field and ground-truth

<div align=center><img height="300" src="https://github.com/shengzesnail/coarse_to_fine_HS_PIV/blob/master/data/uv.png"/></div>


