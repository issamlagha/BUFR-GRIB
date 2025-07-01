#!/bin/bash 


gfortran  aladin_champs_alt_v4_24.f  -o   aladin_champs_alt_v4_24.exe 
gfortran  aladin_pv2_v4_24.f    -o   aladin_pv2_v4_24.exe 
gfortran  aladin_lapot_v4_24.f  -o   aladin_lapot_v4_24.exe 
gfortran  aladin_champs_surf_v4_24.f -o aladin_champs_surf_v4_24.exe 
gfortran  aladin_tetae_v4_24.f -o aladin_tetae_v4_24.exe 
gfortran  aladin_champs_alt_v4_48.f  -o   aladin_champs_alt_v4_48.exe
gfortran  aladin_pv2_v4_48.f    -o   aladin_pv2_v4_48.exe
gfortran  aladin_lapot_v4_48.f  -o   aladin_lapot_v4_48.exe
gfortran  aladin_champs_surf_v4_48.f -o aladin_champs_surf_v4_48.exe
gfortran  aladin_tetae_v4_48.f -o aladin_tetae_v4_48.exe

mv *.exe   $HOME/RESTOR/ALADIN/programs 

