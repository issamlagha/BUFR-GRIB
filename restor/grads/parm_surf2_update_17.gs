jts = 5
nlevs = 3
jte = 17
ntims = 1
wskp = 4
'open aladinS.ctl'
'q file '
ii  = 1
it0 = jts

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
'set rgb 78  105   0   0'
'set rgb 79   85   0   0'
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
'set rgb 98    0 200   0'
'set rgb 99    0 220   0'
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
it1=it0-4
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
if (hh=12);'d ((pgec(t='it0')+pcon(t='it0')))/10';endif
if (hh=24);'d (((pgec(t='it0')+pcon(t='it0'))) - ((pgec(t='it1')+pcon(t='it1'))))/10';endif
if (hh=36);'d (((pgec(t='it0')+pcon(t='it0'))) - ((pgec(t='it1')+pcon(t='it1'))))/10';endif
if (hh=48);'d (((pgec(t='it0')+pcon(t='it0'))) - ((pgec(t='it1')+pcon(t='it1'))))/10';endif
'draw shp alg.shp'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Cumuls Pluies en 12h (mm)'
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
'gxprint ../ALADIN/tmp/work/surface/rr12h_'ii'.png png x800 y800 white'
  'reset'
*-----------
'set t 'it0
*-----------
it1=it0-4
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
'set cmin 0.5'
'set cint 0.5'
'set gxout shaded'
'set mpdset hires'
*colndx='0 0.5 1  3  6  9 12 15 20 25 30 35 40 45 50 55 60 70 80 90 100'
colndx='0 1  3  6  9 12 15 20 25 30 35 40 45 50 55 60 70 80 90 100'
colevs='0 0 30 29 28 27 26 25 33 34 39 40 41 42 43 44 45 46 70 71  72 1'
'set clevs 'colndx
'set ccols 'colevs
if (hh=12);'d ((ngec(t='it0')+ncon(t='it0'))*0.909)/10';endif
if (hh=24);'d (((ngec(t='it0')+ncon(t='it0'))) - ((ngec(t='it1')+ncon(t='it1')))*0.909)/10';endif
if (hh=36);'d (((ngec(t='it0')+ncon(t='it0'))) - ((ngec(t='it1')+ncon(t='it1')))*0.909)/10';endif
if (hh=48);'d (((ngec(t='it0')+ncon(t='it0'))) - ((ngec(t='it1')+ncon(t='it1')))*0.909)/10';endif
'draw shp alg.shp'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Ep Neige en 12h '
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
'set display color white'
'gxprint ../ALADIN/tmp/work/surface/nn12h_'ii'.png png x800 y800 white'
'reset'
*-----------
ii=ii+1
it0 = it0 + 4
endwhile
************************
ii = 1
it0 = 9
while (it0 <= jte)
*-----------
'set t 'it0
*-----------
it1=it0-8
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
if (hh=24);'d ((pgec(t='it0')+pcon(t='it0')))/10';endif
if (hh=48);'d (((pgec(t='it0')+pcon(t='it0'))) - ((pgec(t='it1')+pcon(t='it1'))))/10';endif
'draw shp alg.shp'
'run cbarn.gs'
'set strsiz .17'
'set string 1 l 6'
'draw string 0.8 10.8 '  ' Cumuls Pluies en 24h (mm)'
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
'gxprint ../ALADIN/tmp/work/surface/rr24h_'ii'.png png x800 y800 white'
  'reset'
*-----------
ii=ii+1
it0 = it0 + 8
endwhile
'quit'
'quit'
