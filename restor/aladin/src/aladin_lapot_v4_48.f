      program lapot
      parameter (imll=350,jmll=350,IECMAX=17)
      parameter (KNI=imll*jmll,nlev=4)  ! nombre de point
      parameter (IPALD=8,ipmax=14)
      parameter (term=1.e5)
      DIMENSION XLAT(KNI),XLON(KNI), PFIELD(KNI,IPALD,IECMAX)
      DIMENSION ZFIELD(imll,jmll,IPALD,IECMAX)
      common tetae(imll,jmll),tetase(imll,jmll),
     &       ES(imll,jmll),ESD(imll,jmll),TP(imll,jmll)
      dimension tseb87(imll,jmll),tseb75(imll,jmll)
      dimension teb87(imll,jmll),teb75(imll,jmll)
      dimension con87(imll,jmll),con75(imll,jmll)
      dimension clat87(imll,jmll),clat75(imll,jmll)
      dimension pot87(imll,jmll),pot75(imll,jmll)
      dimension xlap87(imll,jmll)
      dimension tseb18(imll,jmll),teb18(imll,jmll),con18(imll,jmll) 
      dimension pot18(imll,jmll),clat18(imll,jmll),xlap18(imll,jmll)
       dimension xlap75(imll,jmll)
       dimension pte99(imll,jmll),pte85(imll,jmll)
     &,pte70(imll,jmll),TT(imll,jmll),R(imll,jmll)
       dimension pte50(imll,jmll),pts99(imll,jmll)
     &,pts85(imll,jmll)
       dimension pts70(imll,jmll),pts50(imll,jmll) 
       dimension pres(nlev)
         character ent(IPALD)*12,file1*20,xech*2,ent1*10
         dimension iech(IECMAX),len(IPALD)
         real EP
         integer ilev 
        data (ent(i),i=1,IPALD) /'t1000','t850','t700','t500'
     &                          ,'h1000','h850','h700','h500'/ 
        data (len(i),i=1,IPALD) /5,4,4,4,5,4,4,4/
        data pres/1000.,850.,700.,500./

        pi=4.*atan(1.)
        rad=pi/180.

         open(12,file=
     &      '../../SORTIE/lapot.dat',
     &       access='DIRECT',recl=imll*jmll*4) 
!#################################
!#      read data for ALADIN
!#################################
        do iec=1,IECMAX
        do ip=1,IPALD
        ent1=ent(ip)
        if (iec .le. 17 ) THEN
        iech(iec)=(iec-1)*3
        else
        iech(iec)=48 + (iec-17) 
        endif

        write(xech,'(i2.2)') iech(iec)
      !   write(*,*) ent(ip)
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
!==========================================
!  CALCUL TETAE
C     calcul de la temperature potentielle TP.
C     calcul de la tension saturante ES a T.
C     calcul de la tension saturante ESD a TD(tension reelle).
C     calcul de la temperature potentielle equivalente TETAE.
C     calcul de la temperature potentielle equiv_satur TETASE.
C     calcul du rapport de melange(mixing ratio) q.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      EP=0.622

      do iec=1,IECMAX

        DO I=1,imll
        DO J=1,jmll
!     niveau 1000, pres(1)
        TT(I,J)=ZFIELD(I,J,1,iec)-273.16
        R(I,J) =ZFIELD(I,J,5,iec) *100.
       ! write(*,*) TT(I,J), R(I,J)
        ilev=1
      TP(I,J)=(TT(I,J)+273.16)*(1000./pres(ilev))**0.286
      ES(I,J)=6.11*10**((7.5*TT(I,J))/(237.3+TT(I,J)))
      ESD(I,J)=R(I,J)*ES(I,J)/100.
      TETAE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ESD(I,J)
      TETASE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ES(I,J)
        pte99(I,J)=tetae(I,J)
        pts99(I,J)=tetase(I,J)
        ENDDO
        ENDDO 
! 
        DO I=1,imll
        DO J=1,jmll
!     niveau 850, pres(2)
        TT(I,J)=ZFIELD(I,J,2,iec)-273.16
        R(I,J) =ZFIELD(I,J,6,iec) *100.
        ilev=2
      TP(I,J)=(TT(I,J)+273.16)*(1000./pres(ilev))**0.286
      ES(I,J)=6.11*10**((7.5*TT(I,J))/(237.3+TT(I,J)))
      ESD(I,J)=R(I,J)*ES(I,J)/100.
      TETAE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ESD(I,J)
      TETASE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ES(I,J)
        pte85(I,J)=tetae(I,J)
        pts85(I,J)=tetase(I,J)

        ENDDO
        ENDDO 
! 
        DO I=1,imll
        DO J=1,jmll
!     niveau 700, pres(3)
        TT(I,J)=ZFIELD(I,J,3,iec)-273.16
        R(I,J) =ZFIELD(I,J,7,iec) *100.
        ilev=3
      TP(I,J)=(TT(I,J)+273.16)*(1000./pres(ilev))**0.286
      ES(I,J)=6.11*10**((7.5*TT(I,J))/(237.3+TT(I,J)))
      ESD(I,J)=R(I,J)*ES(I,J)/100.
      TETAE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ESD(I,J)
      TETASE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ES(I,J)
        pte70(I,J)=tetae(I,J)
        pts70(I,J)=tetase(I,J)
        ENDDO
        ENDDO
! 
        DO I=1,imll
        DO J=1,jmll
!     niveau 500, pres(4)
        TT(I,J)=ZFIELD(I,J,4,iec)-273.16
        R(I,J) =ZFIELD(I,J,8,iec) *100.
        ilev=4
      TP(I,J)=(TT(I,J)+273.16)*(1000./pres(ilev))**0.286
      ES(I,J)=6.11*10**((7.5*TT(I,J))/(237.3+TT(I,J)))
      ESD(I,J)=R(I,J)*ES(I,J)/100.
      TETAE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ESD(I,J)
      TETASE(I,J)=TP(I,J)+1.555*(1000./pres(ilev))*ES(I,J)
        pte50(I,J)=tetae(I,J)
        pts50(I,J)=tetase(I,J)
        ENDDO
        ENDDO
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
C     calcul de LA TPE MOYENNE(105_70,70_50)
C     calcul de l'indice d'instabilite potentielle(105_70,70_50)
C     calcul de l'indice d'instabilite LATENTE(105_70,70_50)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        DO i=1,imll
        DO j=1,jmll
c     calcul des tetase moyens
        tseb87(i,j)=(pte85(i,j)+pts70(i,j))/2.
        tseb75(i,j)=(pte70(i,j)+pts50(i,j))/2.
        tseb18(i,j)=(pte99(i,j)+pts85(i,j))/2.
c     calcul des tetae moyens
        teb87(i,j)=(pte85(i,j)+pte70(i,j))/2.
        teb75(i,j)=(pte70(i,j)+pte50(i,j))/2.
        teb18(i,j)=(pte99(i,j)+pte85(i,j))/2.
c     calcul des indices ins condi.
        con87(i,j)=term*(1./tseb87(i,j))*( pts70(i,j)-pts85(i,j))/150.
        con75(i,j)=term*(1./tseb75(i,j))*( pts50(i,j)-pts70(i,j))/200.
        con18(i,j)=term*(1./tseb18(i,j))*( pts85(i,j)-pts99(i,j))/150.
        
        clat87(i,j)=term*(1./tseb87(i,j))*( pts70(i,j)-pte85(i,j))/150.
        clat75(i,j)=term*(1./tseb75(i,j))*( pts50(i,j)-pte70(i,j))/200.
        clat18(i,j)=term*(1./tseb18(i,j))*( pts85(i,j)-pte99(i,j))/150.
        
        pot87(i,j)=term*(1./teb87(i,j))*( pte70(i,j)-pte85(i,j))/150.
        pot75(i,j)=term*(1./teb75(i,j))*( pte50(i,j)-pte70(i,j))/200.
        pot18(i,j)=term*(1./teb18(i,j))*( pte85(i,j)-pte99(i,j))/150.
c     calcul des lapotpot87
        xlap87(i,j)= clat87(i,j)+pot87(i,j)
        xlap75(i,j)= clat75(i,j)+pot75(i,j)
        xlap18(i,j)= clat18(i,j)+pot18(i,j)
        ENDDO 
        ENDDO
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         write(12,rec=ipmax*(iec-1)+1) con18
         write(12,rec=ipmax*(iec-1)+2) con87
         write(12,rec=ipmax*(iec-1)+3) con75
      
         write(12,rec=ipmax*(iec-1)+4) clat18
         write(12,rec=ipmax*(iec-1)+5) clat87
         write(12,rec=ipmax*(iec-1)+6) clat75
      
         write(12,rec=ipmax*(iec-1)+7) pot18
         write(12,rec=ipmax*(iec-1)+8) pot87
         write(12,rec=ipmax*(iec-1)+9) pot75

         write(12,rec=ipmax*(iec-1)+10) xlap18
         write(12,rec=ipmax*(iec-1)+11) xlap87
         write(12,rec=ipmax*(iec-1)+12) xlap75
      
         write(12,rec=ipmax*(iec-1)+13) pte99
         write(12,rec=ipmax*(iec-1)+14) pte85
c      write(13,rec=4*(iec-1)+4) pte50
c      write(14,rec=4*(iec-1)+2) pts99
c      write(14,rec=4*(iec-1)+4) pts85
      end do      !  iecmax

      close(12)
      stop
      END
