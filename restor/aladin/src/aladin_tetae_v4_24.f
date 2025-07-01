      program tetae_cal
      parameter(KNI=122500,LMAX=1,IPALD=2,IECMAX=9,imll=350,jmll=350)
      parameter (xl=2.5*1.E6,CP=1005)
      DIMENSION XLAT(KNI),XLON(KNI), PFIELD(KNI,IPALD,IECMAX)
      DIMENSION ZFIELD(imll,jmll,IPALD,IECMAX)
      DIMENSION TETAE(imll,jmll),R(imll,jmll),TT(imll,jmll),q(imll,jmll)
      DIMENSION TP(imll,jmll),ES(imll,jmll),ESD(imll,jmll),
     &          TETASE(imll,jmll)
      DIMENSION pres(imll,jmll),TE(imll,jmll),term(imll,jmll)      
      character ent(IPALD)*12,file1*20,xech*2,ent1*10
      dimension len(IPALD)       
         integer iech, iec, ip
        data (ent(i),i=1,IPALD) /'t2m','mslp'/
        data (len(i),i=1,IPALD) /3,4/

      pi=4.*atan(1.)
      rad=pi/180.
      EP=0.622

       open(13,file='../../SORTIE/tetaes.dat'
     &,access='DIRECT'
     &,recl=imll*jmll*4) 


!#################################
!#      read data for ALADIN
!#################################

        do iec = 1,IECMAX
        do ip = 1,IPALD
        ent1=ent(ip)
        iech=(iec-1)*3
        write(xech,'(i2.2)') iech
!         write(*,*) ent(ip)
        ilen=len(ip)
        file1=ent(ip)(1:ilen)//'_'//xech
!        write(*,*) ' iec= ',iec,file1
!==================== lecture des donn�es entr�e=============
        OPEN(UNIT=11,
     &  FILE='../work/'//file1)

          DO J=1,KNI
             READ(11,*) XLON(J),XLAT(J),PFIELD(J,ip,iec)
          ENDDO
          CLOSE(11)
! convertir les donnees en 2 D
           N=0
          DO J=1,jmll
          DO I=1,imll
           N=N+1
           ZFIELD(I,J,ip,iec)=PFIELD(N,ip,iec)
          ENDDO
          ENDDO
       enddo     ! ipmax
       enddo     ! iecmax



      DO iec =1,IECMAX
! INITIALISATION           CALL init
           do i=1,imll
           do j=1,jmll
              TT(i,j)=ZFIELD(I,J,1,iec)      ! Temperature
              pres(i,j)=ZFIELD(I,J,2,iec)    ! MSLP 
              q(i,j)=ZFIELD(I,J,2,iec)       ! MSLP 
      
!C     calcul de la temperature potentielle TP.:
!C     calcul de la tension saturante ES a T.
!C     calcul de la tension saturante ESD a TD(tension reelle).
!C     calcul de la temperature potentielle equivalente TETAE.
!C     calcul de la temperature potentielle equiv_satur TETASE.
!C     calcul du rapport de melange(mixing ratio) q.

             term(i,j)=1.0/q(i,j)
             R(i,j)=1./(term(i,j)-1.)
             TE(I,J)=TT(I,J)+xl*(R(i,j)/cp)
             TP(I,J)=(TT(I,J))*(1000./pres(i,j))**0.286
             TETAE(I,J)=(TE(I,J))*(1000./pres(i,j))**0.286
!c      ES(I,J)=6.11*10**((7.5*TT(I,J))/(237.3+TT(I,J)))
             ESD(I,J)=R(I,J)*pres(i,j)/(r(i,j)+0.622)
!c      TETAE(I,J)=TP(I,J)+1.555*(1000./pres(in))*ESD(I,J)
             TETASE(I,J)=TP(I,J)+1.555*(1000./pres(i,j))*ESD(I,J)
          enddo
          enddo

       ira1=iec       
        write(13,rec=ira1) tetae

       end do    
      
      close(13)

      stop
      END
