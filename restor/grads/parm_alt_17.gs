
** Need input data on p levels
* run plevels1
'run rgbset.gs'

ll = 1
llf = 4 

lev1=500
lev2=700
lev3=850
lev4=1000

'open aladinP.ctl'

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
jte = 17
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
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
'set clevs 70 75 80 85 90 95 100'
'set ccols 0 70 71 72 73 74 75 76'
'd rh*100'
'set gxout contour'
'set ccolor 1'
'set cthick 6'
'set cint 40'
'set csmooth on'
'd h/10'
'draw shp alg.shp'
'set cthick 6'
'set csmooth on'
'set cint 2'
'set ccolor 2'
'd t-273'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 ' level ' hPa Geop (mgp), T(C,rouge), RH'
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
'draw string 3.5 0.7 ' 'Aladin/Algerie'

'run cbarn.gs'
'gxprint ../ALADIN/tmp/work/altitude/zt'level'_'it0'.png png x800 y800 white'
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
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
*'set clevs 10 20 30 40 50 60 70 80 90 100'        
*'set ccols 0 0 0  0 0 33 34 35 36 37 38  39'
'd tetae - 273'
'set strsiz .20'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' hPa THETA.PRIM.W (C)'
'draw shp alg.shp'
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
'draw string 3.5 0.7 ' 'Aladin/Algerie'
'run cbarn.gs'
'gxprint ../ALADIN/tmp/work/derive/tetaw'level'_'it0'.png png x800 y800 white'

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
'd w'
'set cmin 0'
'set ccolor 2'
'd w'
*'draw shp alg.shp'
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
'draw string 3.5 0.7 ' 'Aladin/Algerie'
'run cbarn.gs'
'gxprint ../ALADIN/tmp/work/derive/vv'level'_'it0'.png png x800 y800 white'

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
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 9 1 9'
'set gxout contour'
'c'
'define wspd=(sqrt(u*u + v*v))'
'set ccolor 1'
'set cthick 6'
'set cint 40'
'set csmooth on'
'd h/10'
*'draw shp alg.shp'
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
'draw string 0.5 10.8 ' level ' hPa Geop (mgp), Vents(Kt)'
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
'draw string 3.5 0.7 ' 'Aladin/Algerie'
*'run cbarn.gs'
'gxprint ../ALADIN/tmp/work/altitude/zv'level'_'it0'.png png x800 y800 white'

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
'set mpdset hires'
'set lev 'level
'set grads off'
'set map 15 1 6'
'set gxout shaded'
'set clevs 70 75 80 85 90 95 100'
'set ccols 0 70 71 72 73 74 75 76'
'd rh*100'
'draw shp alg.shp'
'set gxout contour'
'set ccolor 1'
'set cthick 6'
'set csmooth on'
'set cint 40'
'set csmooth on'
'd h/10'
'set strsiz .15'
'set string 1 l 6'
'draw string 0.5 10.8 ' level ' hPa Geop (mgp)  Humidite Rel'
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
'draw string 3.5 0.7 ' 'Aladin/Algerie'
'run cbarn.gs'
'gxprint ../ALADIN/tmp/work/altitude/rh'level'_'it0'.png png x800 y800 white'

*********************************************************************************************************
 'reset'
it0 = it0 + 1
endwhile it0
return
