fname2='station1.dat'
while (1)
rs=read(fname2)
icode=sublin(rs,1)
*say ' icode ' icode
card=sublin(rs,2)
stn=subwrd(card,1)
lat=subwrd(card,2)
lon=subwrd(card,3)
*say ' STN ' stn
if(icode = 0)
*if(lon>=lon1o &lon<=lon2o &lat<=lat2o & lat>=lat1o)
x0=lon
y0=lat
'q w2xy '%x0%' '%y0
lon0 = subwrd(result,3)
lat0 = subwrd(result,6)
'draw mark 3  'lon0' 'lat0' 0.06'
'set string 1'
'set strsiz 0.08 0.08'
lon0=lon0+0.15
*'draw string ' lon0  ' ' lat0  ' ' stn
*endif 
endif
if(icode = 1)
 'c'
 say  ' file not available'
say ' '
say ' press enter to continue'
pull dummy
'quit'
 endif
if(icode != 0)
res=close(fname2)
break
endif
endwhile
