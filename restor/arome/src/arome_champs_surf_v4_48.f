       program fullpos
       parameter (KNI=160000,WIDF=KNI,IM=400,JM=400,LMAX=1)  
        parameter (IECMAX=17,IPMAX=17)
         DIMENSION XLAT(KNI),XLON(KNI), PFIELD(KNI,LMAX)
         DIMENSION ZFIELD(IM,JM,LMAX)
         character ent(ipmax)*12,file1*20,xech*2,ent1*10
         dimension iech(IECMAX),len(ipmax)
	 CHARACTER CONTNAME*80
	 CHARACTER (LEN=259):: FMT1
         CHARACTER (LEN=256):: YFILE_FORCING_IN
         INTEGER  N, I, J
        data (ent(i),i=1,IPMAX) /'t2m','clsu','clsv','clsh','acpluie',
     &    'acneige','acgraupel','uraf','vraf','neb_hau','neb_moy',
     &    'neb_bas','neb_tot','neb_conv','mslp','wat_vap','cape'/ 

        data (len(i),i=1,IPMAX) /3,4,4,4,7,7,9,4,4,7,7,7,7,8,4,7,4/
        open(1,
     &  file='../../SORTIE/AROME_SURF.dat',
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
         READ(11,*) XLON(J),XLAT(J),(PFIELD(J,L),L=1,LMAX)
c           write(*,*) xlon(j),xlat(j),pfield(j,1),pfield(j,10)
       ENDDO
       
         CLOSE(11)
!==========================================
!c convertir les donn�es en 2 D
c          N=0
         DO LL=1,LMAX
         l = LMAX+1-ll
          N=0
         DO J=1,JM
         DO I=1,IM     
           N=N+1
           ZFIELD(I,J,L)=PFIELD(N,LL)
         ENDDO
         ENDDO
         enddo

         do l=1,lmax
c         irc=(iec-1)*ipmax*Lmax+(ip-1)*lmax+l
          irc=(iec-1)*ipmax+ip 
c         write(*,*) 'irc= ',irc
         write(1,rec=irc) ((ZFIELD(i,j,L),i=1,im),j=1,jm)
         enddo
         enddo
         enddo
         close(1)
          
c
      STOP
      END       
