jts = 1
nlevs = 3
jte = 9
ntims = 1
wskp = 4
'open aladinP.ctl'
'q file '
it0 = jts
***********************
while (it0 <= jte) 
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3  
chh=hh
if (hh<10);chh='0'hh;endif
##########################################
#'enable print ../gif/KI_'chh
#KI=(T850-T500)+Td850-(T700-Td700)
'set mpdset hires'
'set gxout contour'
'set font 2'
'set grid off'
'set poli on'
'set map 1 1 7'
'set cthick 6'
'define t850 = (t.1(lev=850)-273.15)'
'define t700= (t.1(lev=700)-273.15)'
'define t500= (t.1(lev=500)-273.15)'
'define rh850= rh.1(lev=850)'
'define rh700= rh.1(lev=700)'
'define dewp850=t850-((14.55+0.114*t850)*(1-rh850)+pow((2.5+0.007*t850)*(1-rh850),3) + (15.9+0.117*t850)*pow((1-rh850),14))'
'define dewp700=t700-((14.55+0.114*t700)*(1-rh700)+pow((2.5+0.007*t700)*(1-rh700),3) + (15.9+0.117*t700)*pow((1-rh700),14))'
'define KI=(t850-t500)+dewp850-(t700-dewp700)'
'set ccolor 8'
'set cmin 22'
'set cmax 26'
'set cint 2'
'd KI'
'set ccolor 9'
'set cint 2'
'set cmin 28'
'set cmax 32'
'd KI'
'set ccolor 2'
'set cmin 34'
'set cint 2'
'd KI'
'draw title K Index 'hh'h valid: 'fct
'draw xlab '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/KI_'it0'.png'
'disable gxprint'
'reset'
##########################################
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3  
chh=hh
if (hh<10);chh='0'hh;endif
#'enable print ../gif/divq85_'chh
###############################################
'reset'
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3  
chh=hh
if (hh<10);chh='0'hh;endif
'set mpdset hires'
################################################
'set poli on'
'set map 1 1 7'
'set gxout contour'
'set cthick 6'
'set cint 200'
'set cmax 28200'
'set ccolor 4'
*'d h.1(lev=700)-h.1(lev=1000)' 
'set cthick 6'
'set cint 20'
*'set cmin 28400'
'set ccolor 2'
'set grads off'
'd h.1(lev=500)/10-h.1(lev=1000)/10'
'draw title  Ep 1000/500 hPa 'hh'h valid:'fct
'draw xlab  '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/ep10_50_'it0'.png'

'disable gxprint'
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
#'enable print ../gif/ep1000-700_'chh
'set mpdset hires'
################################################
'set poli on'
'set map 1 1 7'
'set gxout contour'
'set cthick 6'
'set cint 200'
'set cmax 28200'
'set ccolor 4'
'set cthick 6'
'set cint 20'
*'set cmin 28400'
'set ccolor 2'
'set grads off'
'd h.1(lev=700)/10-h.1(lev=1000)/10'
'draw title  Ep 1000/700 hPa 'hh'h valid:'fct
'draw xlab  '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/ep10_70_'it0'.png'
'disable gxprint'
'reset'
 it0 = it0 + 1
endwhile
reinit
*---------------------
'open pvA.ctl'
'q file '
it0 = jts
***********************
while (it0 <= jte) 
*-----------
'set t 'it0
*-----------
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3  
chh=hh
if (hh<10);chh='0'hh;endif
#'enable print ../gif/pv330_'chh
'set mpdset hires'
'set map 1 1 9'
'set gxout shaded'
'set cint 0.5'
'set cmin 1'
'd pv330'
'run cbarn'
'set gxout barb'
'set ccolor 1'
'd skip(u330,12,12);v330'
'set gxout contour'
'set cint 50'
'set ccolor 2'
'd pp330'
' draw title  PV 330 K 'hh'h valid: 'fct
'draw xlab  '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/pv330_'it0'.png'

'disable gxprint'
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
#'enable print ../gif/pv315_'chh
'set mpdset hires'
'set map 1 1 9'
'set gxout shaded'
'set cint 0.5'
'set cmin 0.5'
'd pv315'
'run cbarn'
'set gxout barb'
'set ccolor 1'
'd skip(u315,12,12);v315'
'set gxout contour'
'set cint 50'
'set ccolor 2'
'd pp315'
' draw title  PV 315 K 'hh'h valid: 'fct
'draw xlab  '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/pv315_'it0'.png'

'disable gxprint'
'reset'
 it0 = it0 + 1
endwhile
 'reinit'
*---------------------
'open lapotA.ctl'
'open aladinS.ctl'
'q file '
it0 = jts
***********************
while (it0 <= jte) 
*-----------
'set t 'it0
*-----------
'q time '
xfct=subwrd(result,3)
fct=substr(xfct,4,2)'/'substr(xfct,6,3)'/'substr(xfct,11,2)' 'substr(xfct,1,2)'z'
hh=(it0-1)*3  
chh=hh
if (hh<10);chh='0'hh;endif
'set mpdset hires'
'set poli on'
###########################################
'set mpdset hires'
#######################################"
'set mpdset hires'
'set gxout contour'
'set poli on'
'set map 1 1 7'
'set cthick 6'
'set ccolor 4'
'set cmax 5'
'set cint 5'
'd clat18.1'
'set ccolor 2'
'set cmax 0'
'set cint 5'
'd clat18.1'
#'run cbarn'
' draw title INLAT 1000/850 'hh'h valid:'fct
'draw xlab  '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/instl_10_85_'it0'.png'

'disable gxprint'
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
#'enable print ../gif/lat87_'chh
'set mpdset hires'
###################################""""
'set mpdset hires'
'set xlopts 12 5 0.1'
'set ylopts 12 5 0.1'
'set xlint 5'            
'set ylint 5'            
  'set rgb 17  30  30  30'
  'set rgb 18  50  50  50'
  'set rgb 19  85  85  85'
  'set rgb 20 103 103 103'
  'set rgb 21 111 111 111'
  'set rgb 22 136 136 136'
  'set rgb 23 143 143 143'
  'set rgb 24 150 150 150'
  'set rgb 25 157 157 157'
  'set rgb 26 164 164 164'
  'set rgb 27 171 171 171'
  'set rgb 28 178 178 178'
  'set rgb 29 185 185 185'
  'set rgb 30 192 192 192'
  'set rgb 31 199 199 199'
  'set rgb 32 206 206 206'
  'set rgb 33 213 213 213'
  'set rgb 34 220 220 220'
  'set rgb 35 227 227 227'
  'set rgb 36 234 234 234'
  'set rgb 37 241 241 241'
  'set rgb 38 248 248 248'
  'set rgb 39 255 255 255'
ccols='set ccols 39 38 37 36 35 34 33 32 31 30 28 27 26 25 24 23 22 21 20 19 18 17'
clevs='set clevs 0 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 2000' 
clevs
ccols
'set gxout shaded'
'set grads off'
'set grid off'
'set cmin 200'
'set cint 100'
*'d ps.2(t=2)'
####################################
'set mpdset hires'
'set gxout contour'
'set poli on'
'set map 1 1 7'
'set cthick 6'
'set ccolor 4'
'set cmax 5'
'set cint 5'
'd clat87.1'
'set ccolor 2'
'set cmax 0'
'set cint 5'
' d clat87.1'
######################"
' draw title INLAT 850/700 'hh'h valid:'fct
'draw xlab  '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/instl_85_70_'it0'.png'

'disable gxprint'
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
#'enable print ../gif/lat75_'chh
'set mpdset hires'
'set mpdset hires'
###################################""""
'set mpdset hires'
'set xlopts 12 5 0.1'
'set ylopts 12 5 0.1'
'set xlint 5'            
'set ylint 5'            
  'set rgb 17  30  30  30'
  'set rgb 18  50  50  50'
  'set rgb 19  85  85  85'
  'set rgb 20 103 103 103'
  'set rgb 21 111 111 111'
  'set rgb 22 136 136 136'
  'set rgb 23 143 143 143'
  'set rgb 24 150 150 150'
  'set rgb 25 157 157 157'
  'set rgb 26 164 164 164'
  'set rgb 27 171 171 171'
  'set rgb 28 178 178 178'
  'set rgb 29 185 185 185'
  'set rgb 30 192 192 192'
  'set rgb 31 199 199 199'
  'set rgb 32 206 206 206'
  'set rgb 33 213 213 213'
  'set rgb 34 220 220 220'
  'set rgb 35 227 227 227'
  'set rgb 36 234 234 234'
  'set rgb 37 241 241 241'
  'set rgb 38 248 248 248'
  'set rgb 39 255 255 255'
ccols='set ccols 39 38 37 36 35 34 33 32 31 30 28 27 26 25 24 23 22 21 20 19 18 17'
clevs='set clevs 0 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 2000' 
clevs
ccols
'set gxout shaded'
'set grads off'
'set grid off'
'set cmin 200'
'set cint 100'
*'d ps.2(t=2)'
*'basemap O 5'
####################################
'set mpdset hires'
'set gxout contour'
'set poli on'
'set map 1 1 7'
'set cthick 6'
'set ccolor 4'
'set cmax 10'
'set cint 5'
'd clat75.1'
'set ccolor 2'
'set cmax 0'
'set cint 5'
'd clat75.1'
####################################
' draw title INLAT 700/500 'hh'h valid:'fct
'draw xlab   '
'gxprint'
'set display color white'
'gxprint ../ALADIN/tmp/work/derive/instl_70_50_'it0'.png'

'disable gxprint'
'reset'
 it0 = it0 + 1
endwhile
'quit'
