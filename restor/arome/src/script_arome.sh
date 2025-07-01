#!/bin/bash 


gfortran  arome_champs_alt_12_v4.f  -o   arome_champs_alt_12_v4.exe 
gfortran  arome_champs_surf_v4_48.f    -o   arome_champs_surf_v4_48.exe 
gfortran  arome_champs_alt_v4_24.f  -o   arome_champs_alt_v4_24.exe 
gfortran  arome_textreme_12_v4.f -o arome_textreme_12_v4.exe 
gfortran  arome_champs_alt_v4_48.f -o arome_champs_alt_v4_48.exe 
gfortran  arome_textreme_v4_24.f  -o   arome_textreme_v4_24.exe
gfortran  arome_textreme_v4_48.f   -o   arome_textreme_v4_48.exe
gfortran  arome_champs_surf_12_v4.f  -o   arome_champs_surf_12_v4.exe
gfortran  arome_champs_surf_v4_24.f  -o arome_champs_surf_v4_24.exe


mv *.exe   /home/cbouzerma/RESTOR/AROME/programs 

