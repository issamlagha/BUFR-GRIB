       program fullpos
       parameter (KNI=160000,WIDF=KNI,IM=400,JM=400,LMAX=8)  
        parameter (IECMAX=17,IPMAX=18)
         DIMENSION XLAT(KNI),XLON(KNI), PFIELD(KNI,LMAX)
         DIMENSION ZFIELD(IM,JM,LMAX)
         character ent(ipmax)*12,file1*20,xech*2,ent1*10
         dimension iech(IECMAX),len(ipmax)
	 CHARACTER CONTNAME*80
	 CHARACTER (LEN=259):: FMT1
         CHARACTER (LEN=256):: YFILE_FORCING_IN
         INTEGER  N, I, J

        data (ent(i),i=1,IPMAX) /'T','H','UU','VV','cld_wat',
     &    'cld_fra','ice_cry','snow','rain','graupel','tke',
     &    'temp_pot','THETA','vert_vel','pot_vort','vvert',
     &    'abs_vort','div'/

        data (len(i),i=1,IPMAX) /1,1,2,2,7,7,7,4,4,7,3,8,5,8,8,5,
     &                       8,3/
        open(1,file='../SORTIE/r12/AROME_ALT_12.dat',access='direct',
     &   form='unformatted',recl=im*jm*4)
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
	OPEN(UNIT=11,FILE='../output/r12/'//file1)
!     &        ,FORM='FORMATTED',RECL=WIDF)

 
       DO J=1,KNI
         READ(11,*) XLON(J),XLAT(J),(PFIELD(J,L),L=1,LMAX)
       ENDDO
       
         CLOSE(11)
!==========================================
!c convertir les donn�es en 2 D
c          N=0
      DO ll=1,LMAX
!         l = LMAX+1-ll
         l = ll
          N=0
         DO J=1,JM
         DO I=1,IM     
           N=N+1
           ZFIELD(I,J,l)=PFIELD(N,ll)
         ENDDO
         ENDDO
      ENDDO

         do l=1,lmax
         irc=(iec-1)*ipmax*lmax+(ip-1)*lmax+l
c          irc=(iec-1)*ipmax+ip 
c         write(*,*) 'irc= ',irc
         write(1,rec=irc) ((ZFIELD(i,j,l),i=1,im),j=1,jm)
         enddo
         enddo
         enddo
         close(1)
          
c
      STOP
      END       
