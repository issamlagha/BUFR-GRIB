       program fullpos
       parameter (KNI=160000,WIDF=KNI,IM=400,JM=400)  
        parameter (IECMAX=9,IPMAX=2,NJOUR=2)
         DIMENSION XLAT(KNI),XLON(KNI), PFIELD(KNI,IPMAX,IECMAX)
         DIMENSION ZFIELD(IM,JM),ZTEMP(KNI,IPMAX,NJOUR)
         DIMENSION TMX(KNI,NJOUR),TMN(KNI,NJOUR)
         character ent(ipmax)*12,file1*20,xech*2,ent1*10
         dimension iech(IECMAX),len(ipmax)
	 CHARACTER CONTNAME*80
	 CHARACTER (LEN=259):: FMT1
         CHARACTER (LEN=256):: YFILE_FORCING_IN
         INTEGER  N, I, J,ip,iec,IJOUR
        data (ent(i),i=1,IPMAX) /'tmax','tmin'/ 

        data (len(i),i=1,IPMAX) /4,4/
        open(1,
     &  file='../../SORTIE/TEMP_EXTREME.dat',
     &  access='direct',form='unformatted',recl=im*jm*4)
c23456
        do iec=1,iecmax
        do ip=1,ipmax
        ent1=ent(ip)
        iech(iec)=(iec-1)*3
        write(xech,'(i2.2)') iech(iec) 
!         write(*,*) ent(ip)
         ilen=len(ip)
        file1=ent(ip)(1:ilen)//'_'//xech
c
!        write(*,*) ' iec= ',iec,file1
!==================== lecture des donn�es entr�e=============
	OPEN(UNIT=11,
     &  FILE='../work/'//file1)
!     &        ,FORM='FORMATTED',RECL=WIDF)

 
       DO J=1,KNI
         READ(11,*) XLON(J),XLAT(J),PFIELD(J,ip,iec)
c           write(*,*) xlon(j),xlat(j),pfield(j,1),pfield(j,10)
       ENDDO
       
         CLOSE(11)
       enddo
       enddo
!######################################
!######  TEMPERATURE MAX et MIN JOUR J
!######################################
       DO I=1,NJOUR
        DO J=1,KNI
        TMX(J,I)=-50.0
        TMN(J,I)=70.0 
        ENDDO
       ENDDO

       DO K=1,8
       DO J=1,KNI
!       ip=1,2   !température max et min
       ZTEMP(J,1,1)= max(TMX(J,1),(PFIELD(J,1,K)-273.15))
       TMX(J,1)=ZTEMP(J,1,1)
       ZTEMP(J,2,1)= min(TMN(J,1),(PFIELD(J,2,K)-273.15))
       TMN(J,1)=ZTEMP(J,2,1)
       ENDDO
       ENDDO
!######################################
!######  TEMPERATURE MAX et MIN JOUR J+1
!######################################
!       DO K=9,16
!       DO J=1,KNI
!!       ip=1,2   !température max et min
!       ZTEMP(J,1,2)= max(TMX(J,2),(PFIELD(J,1,K)-273.15))
!       TMX(J,2)=ZTEMP(J,1,2)
!       ZTEMP(J,2,2)= min(TMN(J,2),(PFIELD(J,2,K)-273.15))
!       TMN(J,2)=ZTEMP(J,2,2)
!       ENDDO
!       ENDDO
!###################################

!==========================================
!c convertir les donn�es en 2 D
      DO IJOUR=1,NJOUR
        DO ip=1,IPMAX

          N=0

         DO J=1,JM
         DO I=1,IM     
           N=N+1
           ZFIELD(I,J)=ZTEMP(N,ip,IJOUR)
         ENDDO
         ENDDO

          irc=(IJOUR-1)*IPMAX+ip 

         write(1,rec=irc) ((ZFIELD(i,j),i=1,im),j=1,jm)

        ENDDO
       ENDDO
         close(1)
          
c
      STOP
      END       
