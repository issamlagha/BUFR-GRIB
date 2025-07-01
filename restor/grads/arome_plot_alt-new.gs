
** Need input data on p levels
* run plevels1
'run rgbset.gs'

ll = 1
llf = 4 

lev1=500
lev2=700
lev3=850
lev4=1000

'open /home/abdelhak/ctl/aromeP_plot.ctl'

level=500

while (ll <= llf)

if (ll = 1);level = lev1;endif
if (ll = 2);level = lev2;endif
if (ll = 3);level = lev3;endif
if (ll = 4);level = lev4;endif
***********************
 rc = geop(level)

ll = ll + 1
endwhile ll

'quit'


function geop(level)

jts = 1
nlevs = 3
jte = 9
ntims = 1
wskp = 4
'q file '
it0 = jts
ana=''
*-----------
'set t 1'
*-----------
'q time '
xfct=subwrd(result,3)
ana=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'

while (it0 <= jte)
****************************************************************
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
****************************************************************
******
*  PLOT HUMIDITE ET TEMPERATURE
******
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
'set clevs 70 75 80 85 90 95 100'
'set ccols 0 70 71 72 73 74 75 76'
'd hum*100'
'set gxout contour'
'set ccolor 1'
'set cthick 6'
'set cint 40'
'set csmooth on'
*'d h/10'
'set cthick 6'
'set csmooth on'
'set cint 4'
'set ccolor 2'
'd temp-273'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 ' level '  T(C,rouge), RH'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'

'run cbarn.gs'
'gxprint /home/abdelhak/altitude/zt'level'_'it0'.png png x800 y800 white'
****************************************************************
****************************************************************
******
*  PLOT TETHA PRIM W
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 10 20 30 40 50 60 70 80 90 100'        
*'set ccols 0 0 0  0 0 33 34 35 36 37 38  39'
'set clevs -6 -4 -2 0 2 4 6 8 10 12 14 16 18 20 22 24'
'set ccols 0 77 78 79 81 82 84 85 86 88 89 90 91 92 94 95 96 99'
'd tetaw - 273'
'set strsiz .20'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' hPa THETA.PRIM.W (C)'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/tetaw'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT VITESSE VERTICALE
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout contour'
*'set clevs 10 20 30 40 50 60 70 80 90 100'        
*'set ccols 0 0 0  0 33 34 35 36 37 38  39'
'set gxout contour'
'set cthick 6'
*'set csmooth on'
*'set cint 4'
'set cmax -0.1'
'set ccolor 4'
'd vvert'
'set cmin 0'
'set ccolor 2'
'd vvert'
'set strsiz .25'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' hPa Vitesse Verticale (Pa/s)'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/vv'level'_'it0'.png png x800 y800 white'

****************************************************************
****************************************************************
******
*  PLOT VENTS
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout contour'
'c'
'define wspd=(sqrt(u*u + v*v))'
'set ccolor 1'
'set cthick 6'
'set cint 40'
'set csmooth on'
*'d h/10'
'set ccolor 3'
'set cthick 3'
'set cint 2.5'
*'d wspd'
'set ccolor 4'
'set gxout barb'
'set cmin 10 '
'd skip(u*1.92,14,14);v*1.92'
'set strsiz .2'
'set string 1 l 6'
'draw string 0.5 10.8 ' level '  Vents(Kt)'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
*'run cbarn.gs'
'gxprint /home/abdelhak/altitude/zv'level'_'it0'.png png x800 y800 white'

****************************************************************
****************************************************************
******
*  PLOT HUMIDITE
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
'set clevs 70 75 80 85 90 95 100'
'set ccols 0 70 71 72 73 74 75 76'
'd hum*100'
'set gxout contour'
'set ccolor 1'
'set cthick 6'
'set csmooth on'
'set cint 40'
'set csmooth on'
*'d h/10'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' Humidite Rel'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/rh'level'_'it0'.png png x800 y800 white'

********************************************************************************************************
****************************************************************
******
*  PLOT CLOUD WATER
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs 0 0.1 0.2 0.3 0.4 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5'
'set ccols 0 78 79 81 82 84 85 87 89 90 92 93 94 95 96 97 99 12'
'd clwat'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' Cloud Water'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/clwat'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT CLOUD FRACTION
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs 0 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1'
'set ccols 0 79 82 84 86 88 89 90 92 93 94 95 96 99 '
'd clfra'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' Cloud fraction'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/clfra'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT ICE CRYSTAL
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs 0 0.5 1 1.5 2 2.5 3 3.5 4 8 12 16 20 24 27'
'set ccols 0 78 81 82 84 86 88 89 90 91 92 93 94 95 96 97'
'd icecr'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' Ice Crystal'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/icecr'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT SNOW
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs 0 3 6 9 12 15 18 21 24 27 30 33'
'set ccols 0 79 82 84 86 88 89 90 92 93 94 95 96 99'
'd snow'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' SNOW'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/snow'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT RAIN
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs 0 3 6 9 12 15 18 21 24 27 31 33'
'set ccols 0 79 82 84 86 88 89 90 92 93 94 95 96 99'
'd rain'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' RAIN'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/rain'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT GRAUPEL
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs 0 0.5 1 2 3 4 5 6 7 9 11 14 17 20'
'set ccols 0 78 81 82 84 86 88 89 90 91 92 93 94 95 96 97'
'd grpl'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' GRAUPEL'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/grpl'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT TKE
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 3 6 9 12 15 18 21 24 27 30'
*'set ccols 0 49 44 37 34 21 22 23 25 67 68 69'
'set clevs 2 3 4 5 6 8 10 12 14 16 18 20'
'set ccols 0 79 82 84 86 88 89 90 92 93 94 95 96 99'
'd tke'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' TKE'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/tke'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT TEMPERATURE POTENTIELLE
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'set clevs -2 0 2 4 6 8 10 12 16 20 22 24 26 28 31 32 34 36 38 40 42 44'
'set ccols 0 77 78 79 80 81 82 83 84 85 86 87 89 90 91 92 93 94 95 96 97 98 99 11 12'
'd tpot'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' T POT'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/tpot'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT VERTICAL VELOCITY
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'd vvelo'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' VERT VELOCITY'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/vvel'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT POTENTIEL VORTICITY
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'd potvor'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' POT VORTICITY'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/potvor'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT ABSOLU VORTICITY
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'd absvor'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' ABS VORTICITY'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/absvor'level'_'it0'.png png x800 y800 white'
****************************************************************
******
*  PLOT DIVERGENCE
******
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif

** Looking for 850 mb  data
say 'Plotting  ' level 'hPa'
'set display color white'
'c'
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 70 75 80 85 90 95 100'
*'set ccols 0 70 71 72 73 74 75 76'
'd div'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' DIVERGENCE'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.5 ' 'Base: ' ana
'set strsiz .16'
'set string 1 l 6'
'draw string 5.0 10.2 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.7 ' 'Arome/Algerie'
'run cbarn.gs'
'gxprint /home/abdelhak/altitude/div'level'_'it0'.png png x800 y800 white'
*******************************************************************************************
*******************************************************************************************
'reset'
it0 = it0 + 1
endwhile it0
return











