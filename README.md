# coarse_to_fine_HS_PIV
coarse-to-fine variational optical flow method for fluid flows

This project is implemented to perform the multi-resolution HS optical flow computing.  

The Horn & Schunck (HS) method, which is also called variational optical flow, is widely used in the computer vision community. 
In this project, we mainly focus on the application of particle image velocimetry (PIV), which is a motion estimation technique for fluid flows.
<br> 

#### Main reference:

	Horn, B. and Schunck, B. (1981) Artificial Intelligent. 17:185-203  
	Ruhnau, P., et al. (2005) Experiments in Fluids 38(1):21-32.  
	Heitz, D., et al. (2010) Experiments in Fluids, 48(3):369-393.  
	Sun, D., et al. (2010). Computer Vision & Pattern Recognition.  


This program the basis of the complex motion estimator for fluid flows:

  Cai, S., Mémin, E., Dérian, P. and Xu, C. (2017). Motion Estimation under Location Uncertainty for Turbulent Fluid Flow. Experiments in Fluids. 59(8). (https://doi.org/10.1007/s00348-017-2458-z)  
  

#### Usage:  Run the script main.m  
  <br> 
#### Example:

The images of this example are originally provided by FLUID - http://fluid.irisa.fr/data-eng.htm  

![image1](coarse_to_fine_HS_PIV/data/image1.png)
![image2](coarse_to_fine_HS_PIV/data/image2.png)



