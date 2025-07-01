
      PROGRAM ERTEL
      parameter(KNI=122500,LMAX=8,IPALD=4,IECMAX=17,imll=350,jmll=350)
         common ipar(imll,jmll),p(imll,jmll),tetae(imll,jmll)
     &,tetase(imll,jmll),H2(imll,jmll),TP(imll,jmll)
         DIMENSION XLAT(KNI),XLON(KNI), PFIELD(KNI,LMAX,IPALD,IECMAX)
         DIMENSION ZFIELD(imll,jmll,LMAX,IPALD,IECMAX)
        DIMENSION p9(imll,jmll,LMAX),top(imll,jmll),qe4(imll,jmll)
      DIMENSION fc(imll,jmll),ppp(imll,jmll),pp2(imll,jmll)
      DIMENSION u9(imll,jmll,LMAX),v9(imll,jmll,LMAX),dp(LMAX-1),
     &          ui(imll,jmll),TT(imll,jmll), R(imll,jmll),ES(imll,jmll),
     &          ESD(imll,jmll),pres(LMAX),press(LMAX)
      DIMENSION qe(imll,jmll,LMAX),pp(LMAX),p1(imll,jmll)
     &,p2(imll,jmll),vi(imll,jmll),tetar(4)
      PARAMETER (G=9.81,TETA0=283.)
      PARAMETER (om=7.29E-5,ray=6336.E+3,xmin=-10.70,ymin=18.55,
     & dellat=.1,term=1.e6)
       integer now(14),idat(3)
      character xdate*8
      character xxdate*12,xm(12)*3,xmois*13,xxm*3
         character ent(IPALD)*12,file1*20,xech*2,ent1*10
         dimension iech(IECMAX),len(IPALD)
         real EP,rrr
         integer ilev, ipp, iec, k1, k2 
        data (ent(i),i=1,IPALD) /'T','RH','UU','VV'/
        data (len(i),i=1,IPALD) /1,2,2,2/

        DATA  pp/100000.,85000.,70000.,50000.,40000.,30000., 
     &    20000.,10000./
        DATA tetar/300.,315.,330.,340./
      
!#################################
!#      read data for ALADIN
!#################################

        do iec = 1,IECMAX
        do ip = 1,IPALD
        ent1=ent(ip)
        iech(iec)=(iec-1)*3
        write(xech,'(i2.2)') iech(iec)
!         write(*,*) ent(ip)
        ilen=len(ip)
        file1=ent(ip)(1:ilen)//'_'//xech
!        write(*,*) ' iec= ',iec,file1
!==================== lecture des donn�es entr�e=============
        OPEN(UNIT=11,
     &  FILE='../work/'//file1)

          DO J=1,KNI
             READ(11,*) XLON(J),XLAT(J),(PFIELD(J,L,ip,iec),L=1,LMAX)
          ENDDO
          CLOSE(11)
! convertir les donnees en 2 D
         DO L=1,LMAX
           N=0
          DO J=1,jmll
          DO I=1,imll
           N=N+1
           ZFIELD(I,J,L,ip,iec)=PFIELD(N,L,ip,iec)
          ENDDO
          ENDDO
          ENDDO
       enddo     ! ipmax
       enddo     ! iecmax
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       DO ik=1,LMAX
       DO i=1,imll
       DO j=1,jmll
        qe(i,j,ik)=-9999.
        qe4(i,j)=-9999.
       END DO  !j
       END DO  !i
       END DO  ! ik

!       enddo     ! iecmax
c     
      pi=4.*atan(1.)
      rad=pi/180.
      GTO=G/TETA0
      GT0=G*G/TETA0
        
      DO in=1,LMAX-1
      dp(in)=pp(in+1)-pp(in)
      END DO ! in

      DO  j=1,jmll
         y=ymin+float(j-1)*dellat
      DO  i=1,imll 
        fc(i,j)=2.*om*sin(y*rad)
      ENDDO !i
      ENDDO !j
!
      Open(17,file='../../SORTIE/pv.dat',
     & ACCESS='DIRECT',recl=imll*jmll*4)
c
      DO iec=2,  IECMAX    !   Boucle echeance     

      DO in=1,LMAX        !   level
c       
! INITIALISATION           CALL init
      DO I=1,imll
      DO J=1,jmll 
         TETAE(I,J)=-9999.
         TP(I,J)=-9999.
         TETASE(I,J)=-9999.
         P(I,J)=-9999.
      ENDDO
      ENDDO
C     calcul de la temperature potentielle TP.
C     calcul de la tension saturante ES a T.
C     calcul de la tension saturante ESD a TD(tension reelle).
C     calcul de la temperature potentielle equivalente TETAE.
C     calcul de la temperature potentielle equiv_satur TETASE.
C     calcul du rapport de melange(mixing ratio) q.
        EP=0.622 
        DO I=1,imll
        DO J=1,jmll
!     niveau 1000, pres(1)
        pres(in)=pp(in)/100.
        TT(I,J)=ZFIELD(I,J,in,1,iec)
        R(I,J) =ZFIELD(I,J,in,2,iec)! *100.
       ! write(*,*) TT(I,J), R(I,J)
      TP(I,J)=TT(I,J)*(1000./pres(in))**0.286
      ES(I,J)=6.11*10**((7.5*TT(I,J))/(237.3+TT(I,J)))
      ESD(I,J)=R(I,J)*ES(I,J)/100.
      TETAE(I,J)=TP(I,J)+1.555*(1000./pres(in))*ESD(I,J)
      TETASE(I,J)=TP(I,J)+1.555*(1000./pres(in))*ES(I,J)
!        pte99(I,J)=tetae(I,J)
!        pts99(I,J)=tetase(I,J)
         p9(I,J,in)=TP(I,J)   !! teta
        ENDDO
        ENDDO
c
!      DO  i=1,imll
!      DO  j=1,jmll
!         p9(i,j,in)=tp(i,j)   !! teta
!       enddo  ! j
!       enddo  !i
c      irang=8*(iec-1)+in
c      write(*,*) irang
c      write(16,rec=irang) ((p9(i,j,in),i=1,imll),j=1,jmll)
        
      END DO  ! in
c

      DO in=1,LMAX

      DO i=1,imll
      DO j=1,jmll
         u9(i,j,in)=ZFIELD(i,j,in,3,iec)   !u
         v9(i,j,in)=ZFIELD(i,j,in,4,iec)   !v 
      enddo  ! j
      enddo  ! i
       
      END DO  ! in
        
      DO in=2,LMAX
      DO  j=2,jmll-1
           jp1=j+1
           jm1=j-1
         ylat=ymin+(j-1)*dellat
         f=2.*om*sin(ylat*rad)
      
      DO  i=2,imll-1
         dx=dellat*rad*ray*cos(ylat*rad)
         dy=dellat*rad*ray
           ip1=i+1
           im1=i-1
           in1=in-1
        qe(i,j,in)=-term*g* (
     &  ((v9(ip1,j,in)-v9(i,j,in))/dx - (u9(i,jp1,in)-u9(i,j,in))/dy +f)
     &  * (p9(i,j,in)-p9(i,j,in1))/dp(in1)
     & -((v9(i,j,in)-v9(i,j,in1))/dp(in1))* (p9(ip1,j,in)-p9(i,j,in))/dx
     &+((u9(i,j,in)-u9(i,j,in1))/dp(in1))* (p9(i,jp1,in)-p9(i,j,in))/dy)
!         write(*,*) f,dx,dy,term,u9(i,j,in),v9(i,j,in),qe(i,j,in)
       enddo   ! j
       enddo   ! i
c        write(*,*) qe(10,10,in)
 
       END DO  ! in
     
C recherche des deux niveaux p1 e p2
      do iteta=1,4
! 
      do i=1,imll
      do j=1,jmll
       qe4(i,j)=-9999.
       pp2(i,j)=-9999.
       ui(i,j)=-9999.
       vi(i,j)=-9999.
      enddo
      enddo
       teta=tetar(iteta)
       do i=2,imll-1 
       do j=2,jmll-1
        do ilev=2,8
       ! write(*,*) 'teta=',teta
       ! write(*,*) 'p9=',p9(i,j,ilev)
        ! write(*,*) 'bien00', 'k1=',k1, ' k2=',k2, ilev
         if(teta.le.p9(i,j,ilev)) then
         k1=ilev-1
         k2=ilev 
!         write(*,*) 'bien00', 'k1=',k1, ' k2=',k2
         goto 1100
         endif
        enddo    ! ilev
!      write(*,*) ' niveau teta non conforme'
        
1100  pl =   pp(k1)/100.
      pt=    pp(k2)/100.
!      write(*,*) 'bien0'
      p1(i,j)=pl
      p2(i,j)=pt
!      write(*,*)teta,p9(i,j,k2),p9(i,j,k1) 
      term1=( teta-p9(i,j,k2) )/( p9(i,j,k1)- p9(i,j,k2) )
 
!      write(*,*) 'bien1'
!      rrr=p9(i,j,k1)- p9(i,j,k2)
      tm1=term1*alog(pt/pl)
!      if(iteta .eq. 1) write(*,*)iec,teta,p9(i,j,k1),p9(i,j,k2)
!      if(iteta .eq. 1) write(*,*) pl,pt,term1,tm1,rrr
!      rrr=p9(i,j,k1)- p9(i,j,k2)
!      write(*,*) p9(i,j,k2),p9(i,j,k1),pt,pl,term1,tm1,rrr 
       pp2(i,j)=pt/exp(tm1)
!       write(*,*) term1,tm1, pp2(i,j)
       AL1 = ALOG(pt/pl)
       AL2 = ALOG(pt/PP2(i,j))
       ALPHA = AL2/AL1
!       write(*,*) AL1,AL2,ALPHA
        qe4(i,j) =(1.-ALPHA)*qe(i,j,k2) + ALPHA*qe(i,j,k1)
!        write(*,*) iec, qe(i,j,k1),qe(i,j,k2),qe4(i,j)
        ui(i,j) =(1.-ALPHA)*u9(i,j,k2) + ALPHA*u9(i,j,k1)
        vi(i,j) =(1.-ALPHA)*v9(i,j,k2) + ALPHA*v9(i,j,k1)
!      write(*,*) 'bien2'
        if(k1.lt.2) then
         qe4(i,j)=-9999.
         ui(i,j)=-9999.
         vi(i,j)=-9999.

         pp2(i,j)=1000.
!      write(*,*) 'bien3'
        endif  
        enddo   ! j
        enddo   ! i
      
        irec1=16*(iec-1)+iteta
        irec2=16*(iec-1)+4+iteta
        irec3=16*(iec-1)+8+iteta
        irec4=16*(iec-1)+12+iteta
        WRITE(17,rec=irec1)((qe4(i,j),i=1,imll),j=1,jmll)
        WRITE(17,rec=irec2)((pp2(i,j),i=1,imll),j=1,jmll)
        WRITE(17,rec=irec3)((ui(i,j),i=1,imll),j=1,jmll)
        WRITE(17,rec=irec4)((vi(i,j),i=1,imll),j=1,jmll)
       enddo    ! iteta

      enddo    ! iech

      close(17)  

!      STOP      
      END
