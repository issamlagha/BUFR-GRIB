jts = 1
nlevs = 3
jte = 17
ntims = 1
wskp = 4
'open aladinS.ctl'
'q file '
it0 = jts
***************************
***************************
'set rgb 20    0  29  29'
'set rgb 21    0  49  49'
'set rgb 22    0  69  69'
'set rgb 23    0  89  89'
'set rgb 24    0 109 109'
'set rgb 25    0 129 129'
'set rgb 26    0 149 149'
'set rgb 27    0 169 169'
'set rgb 28    0 189 189'
'set rgb 29    0 209 209'
'set rgb 30    0 229 229'
'set rgb 31    0 249 249'
'set rgb 32    0 209 255'
'set rgb 33    0 169 255'
'set rgb 34    0 129 255'
'set rgb 35    0  89 255'
'set rgb 36    0  49 255'
'set rgb 37   49   0 255'
'set rgb 38   89   0 255'
'set rgb 39  109   0 255'
'set rgb 40  149   0 255'
'set rgb 41  189   0 255'
'set rgb 42  209   0 255'
'set rgb 43  249   0 255'
'set rgb 44  255   0 209'
'set rgb 45  255   0 169'
'set rgb 46  255   0 129'
'set rgb 47  255   0  89'
'set rgb 48  255   0  49'
'set rgb 50   99   0  99'
'set rgb 51  159   0 159'
'set rgb 52  255   0 255'
'set rgb 53  205   0 255'
'set rgb 54  169   0 255'
'set rgb 55   99   0 255'
'set rgb 56    0   0 255'
'set rgb 57    0  79 255'
'set rgb 58    0 192 255'
'set rgb 59    0 255 255'
'set rgb 60    0 255 195'
'set rgb 61    0 255 179'
'set rgb 62    0 255  79'
'set rgb 63    0 255   0'
'set rgb 64  165 255   0'
'set rgb 65  205 255   0'
'set rgb 66  255 255   0'
'set rgb 67  255 205   0'
'set rgb 68  255 154   0'
'set rgb 69  255 102   0'
'set rgb 70  255   0   0'
'set rgb 71  205   0   0'
'set rgb 72  165   0   0'
'set rgb 73    0   0 255'
'set rgb 74    0 155  29'
'set rgb 75    0 205  79'
'set rgb 76    0 205   0'
'set rgb 77  135   0   0'
'set rgb 78  115   0   0'
'set rgb 79   100 0   0'
'set rgb 80   65   0   0'
'set rgb 81   45   0   0'
'set rgb 82   35  35  35'
'set rgb 83   55  55  55'
'set rgb 84   75  75  75'
'set rgb 85   95  95  95'
'set rgb 86  115 115 115'
'set rgb 87  135 135 135'
'set rgb 88  155 155 155'
'set rgb 89  175 175 175'
'set rgb 90  195 195 195'
'set rgb 91  225 225 225'
*  Terrain ht colors
'set rgb 92    0   0  80'
'set rgb 93    0  30   0'
'set rgb 94    0  60   0'
'set rgb 95    0  90   0'
'set rgb 96    0 120   0'
'set rgb 97    0 160   0'
'set rgb 98    0 210   0'
'set rgb 99    0 230   0'
'set rgb 16  205  85   0'
'set rgb 17  185  60   0'
'set rgb 18  145  50   0'
'set rgb 19  105  40   0'

*-----------
'set t 1'
*-----------
'q time '
xfct=subwrd(result,3)
ana=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'

***********************
while (it0 <= jte)
*-----------
'set t 'it0
*-----------
it1=it0-1
it2=it0-1
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set gxout shaded'
'set mpdset hires'
'set map 1 1 6'
*'set clevs 0.5 1.5 2.5 5 10 15 20 25 30 40 50 60'
*'set rbcols 0 5 11 4 13 10 7 9 14 8 12 15'
'set cmin 0.5'
'set cint 0.5'
if (hh=3);'d ((ngec(t='it0')+ncon(t='it0'))*0.909)/10';endif
if (hh>3);'d (((ngec(t='it0')+ncon(t='it0'))-(ngec(t='it1')+ncon(t='it1')))*0.909)/10';endif
'draw shp alg.shp'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Ep Neige  en 03h '
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
'draw string 3.5 0.7 ' 'Aladin/Algerie (en cm)'
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/surface/neige_'it0'.png png x800 y800 white'
  'reset'
 
*-----------
'set t 'it0
*-----------
it1=it0-1
it2=it0-1
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set mpdset hires'
'set poli on'
'set map 1 1 6'
'set cmin 0.001'
'set cint 0.5'
'set gxout shaded'
'set mpdset hires'
*colndx='0 0.5 1  3  6  9 12 15 20 25 30 35 40 45 50 55 60 70 80 90 100'
colndx='0 1  3  6  9 12 15 20 25 30 35 40 45 50 55 60 70 80 90 100'
colevs='0 0 30 29 28 27 26 25 33 34 39 40 41 42 43 44 45 46 70 71  72 1'
'set clevs 'colndx
'set ccols 'colevs
if (hh=3);'d ((pgec(t='it0')+pcon(t='it0')))/10';endif
if (hh>3);'d (((pgec(t='it0')+pcon(t='it0'))-(pgec(t='it1')+pcon(t='it1'))))/10';endif
'draw shp alg.shp'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Cumuls Pluies en 03h (mm)'
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
'set display color white'
'gxprint ../ALADIN/tmp/work/surface/rr_'it0'.png png x800 y800 white'
  'reset'

'set t 'it0
*-----------
it1=it0-1
it2=it0-1
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set gxout shaded'
'set mpdset hires'
'set map 1 1 9'

*########## PALETTE D'ETE #######
colndx='0 4 8 12 14 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50'
colevs='0 41 40 39 37 35 33 32 31 29 63 64 65 66 67 68 69 70 71 72 77 78 80 82'
*####### PALETTE D HIVER ########
*colndx='-12 -8 -6 -4 -2 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 34 36 38 40'
*colevs='0 43 42 40 39 38 37 35 34 33 32 31 63 64 65 66 67 68 69 70 71 72 77 78 79 80'
*###### PALETTE PRINTEMPS #######
*colndx='0 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42'
*colevs='0 41 40 39 37 35 33 32 31 29 63 64 65 66 67 68 69 70 71 72 77 80 82'
*###############################################
'draw shp alg.shp'
'set clevs 'colndx
'set ccols 'colevs
*'set cint 1'
'set lat 18.5 38.5'
'set lon -9.5 12.5'
'd  t2m - 273.15'
'set gxout contour'
'set cint 3'
'd  t2m - 273.15'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Temperature 2m (Deg C)'
'set strsiz .17'
'set string 1 l 6'
'draw string 1.5 10.4 ' '(ech ' chh 'h)'
'set strsiz .13'
'set string 1 l 6'
'draw string 5.65 10.4 ' 'Base: ' ana
'set strsiz .13'
'set string 1 l 6'
'draw string 5.65 10.1 ' 'Valid: ' fct
'set strsiz .15'
'set string 1 l 6'
'draw string 3.5 0.9 ' 'Aladin/Algerie'
'set display color white'
'gxprint ../ALADIN/tmp/work/surface/t2m_'it0'.png png x800 y800 white'
  'reset'

'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set mpdset hires'
'set gxout barb'
'set poli on'
'set map 9 1 5'
colndx='860 880  900  920 940 950  960 970  980  990  1000  1010  1020  1030  1040  1050  1060'
colevs=' 78  78  77   72  71  70   69  68   67   80   73    35    34    33    33    32    32  32 '
'set clevs 'colndx
'set ccols 'colevs
'set gxout contour'
'set cthick 8'
'set ccolor 1'
'set cint 10'
'd ps/100'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Pression Mer (hPa),Vents (Kts)'
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
'gxprint ../ALADIN/tmp/work/surface/Ps_'it0'.png png x800 y800 white'
'reset'
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set mpdset hires'
'set gxout barb'
'set poli on'
'set map 1 1 9'
colndx='0 5 10 15 20 25 30 35 40 45 50 55 60 65 70'
colevs='0 34 33 32 63 64 65 66 67 68 69 70 71 72 77 80 82'
'set clevs 'colndx
'set ccols 'colevs
'set gxout shaded'
'd mag(u*1.92,v*1.92)'
'run cbarn.gs'
'set ccolor 1'
'set gxout vector'
'set cmin 10 '
'd skip(u*1.92,6,6);v*1.92'
*colndx='940 944 948 952 956 960 965 968 972 976 980 084 988 992 996 1000 1004 1008 1012 1016 1020 1024 1028 1032 1036 1040 1044 1048 1052 1056 1060'
*colevs=' 78  78  77  77  72  72  71  71  71  71  70  70  69  69  68   68   67   67   80   73   73   35   35   34   34   33   33   32   32  32  32  32  32 '
*'set clevs 'colndx
*'set ccols 'colevs
'set gxout contour'
'set cthick 8'
'set ccolor 1'
'set cint 5'
'd mslp/100'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Pression Mer (hPa),Vents (Kts)'
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
'gxprint ../ALADIN/tmp/work/surface/vent_'it0'.png png x800 y800 white'
'reset'
***********************************************************************************
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set mpdset hires'
'set gxout barb'
'set poli on'
'set map 1 1 9'
colndx='0 5 10 15 20 25 30 35 40 45 50 55 60 65 70'
colevs='0 34 33 32 63 64 65 66 67 68 69 70 71 72 77 80 82'
'set clevs 'colndx
'set ccols 'colevs
'set gxout shaded'
'd mag(UR*1.92,VR*1.92)'
'run cbarn.gs'
'set ccolor 1'
'set gxout vector'
'set cmin 10 '
'd skip(UR*1.92,6,6);VR*1.92'
*colndx='940 944 948 952 956 960 965 968 972 976 980 084 988 992 996 1000 1004 1008 1012 1016 1020 1024 1028 1032 1036 1040 1044 1048 1052 1056 1060'
*colevs=' 78  78  77  77  72  72  71  71  71  71  70  70  69  69  68   68   67   67   80   73   73   35   35   34   34   33   33   32   32  32  32  32  32 '
*'set clevs 'colndx
*'set ccols 'colevs
'set gxout contour'
'set cthick 8'
'set ccolor 1'
'set cint 5'
'd mslp/100'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Pression Mer (hPa),RAFAL (Kts)'
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
'gxprint ../ALADIN/tmp/work/surface/rafal_'it0'.png png x800 y800 white'
'reset'

***********************************************************************************
*-----------
'set t 'it0
*-----------
it1=it0-1
it2=it0-1
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3
chh=hh
if (hh<10);chh='0'hh;endif
'set grads off'
'set grid off'
'set gxout shaded'
'set mpdset hires'
'set map 9 1 5'
*'set clevs 1 2.5 5 10 15 20 25 30 40 50 60'
*'set rbcols 0 5 11 4 13 10 7 9 14 8 12 15'
'draw shp alg.shp'
'set cmin 300'
'd cape'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' CAPE (Energie Potentielle Convective disponible) (w/m2)'
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
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/cape_'it0'.png png x800 y800 white'
  'reset'
 
  
*-----------
it0 = it0 + 1
endwhile
'quit'
