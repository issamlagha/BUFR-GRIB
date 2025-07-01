DSET  ../ALADIN/tmp/work/lapot.dat
UNDEF  -9999
TITLE eta model
xdef 350 linear  -10.7 0.080
ydef 350 linear   18.5 0.080
ZDEF   1 LEVELS  1000
TDEF ECHS LINEAR 00Z02Nov2023 03hr 
VARS 12
con18    0 99  conditionnel 1000-850
con87    0 99  conditionnel 850-700
con75    0 99  conditionnel 700-500
clat18    0 99 latent 1000-850
clat87   0 99 latent  850-700
clat75  0 99  latent  700-500
pot18    0 99 potentiel 1000-850
pot87    0 99 potentiel 850-700
pot75    0 99 potentiel 700-500
lap18    0 99 lapot 1000-850
lap87    0 99 lapot 850-700
lap75    0 99 lapot 700-500
ENDVARS
