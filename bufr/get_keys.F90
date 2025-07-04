! (C) Copyright 2005- ECMWF.
!
! This software is licensed under the terms of the Apache Licence Version 2.0
! which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
!
! In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
! virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
!
!
!
! Description: How to use keys_iterator functions and the
!              codes_bufr_keys_iterator structure to get all the available
!              keys in a BUFR message.
!
! Usage: gfortran get_keys.F90 -I/usr/include -L/usr/lib/x86_64-linux-gnu -leccodes_f90 -leccodes -o get_keys_f.exe
program bufr_keys_iterator
   use eccodes
   implicit none
   integer            :: ifile
   integer            :: iret
   integer            :: ibufr
   integer            :: count = 0
   character(len=256) :: key
   integer            :: kiter
   integer            :: subset = 1
 
   !call codes_open_file(ifile, '../../data/bufr/syno_1.bufr', 'r')
   call codes_open_file(ifile, 'bufr.synop', 'r')

   ! The first BUFR message is loaded from file,
   ! ibufr is the BUFR id to be used in subsequent calls
   call codes_bufr_new_from_file(ifile, ibufr, iret)
 
   do while (iret /= CODES_END_OF_FILE)
 
      ! Get and print some keys from the BUFR header
      write (*, *) 'message: ', count
 
      ! We need to instruct ecCodes to expand all the descriptors
      ! i.e. unpack the data values
      call codes_set(ibufr, "unpack", 1);
      ! Create BUFR keys iterator
      call codes_bufr_keys_iterator_new(ibufr, kiter, iret)
 
      if (iret .ne. 0) then
         write (*, *) 'ERROR: Unable to create BUFR keys iterator'
         call exit(1)
      end if
 
      ! Get first key
      call codes_bufr_keys_iterator_next(kiter, iret)
 
      ! Loop over keys
      do while (iret == CODES_SUCCESS)
         ! Print key name
         call codes_bufr_keys_iterator_get_name(kiter, key)
         if (key == 'subsetNumber') then
            write (*, *) '  Subset ', subset
            subset = subset + 1
         else
            write (*, *) '  ', trim(key)
         end if
 
         ! Get next key
         call codes_bufr_keys_iterator_next(kiter, iret)
      end do
 
      ! Delete key iterator
      call codes_bufr_keys_iterator_delete(kiter)
 
      ! Release the BUFR message
      call codes_release(ibufr)
 
      ! Load the next BUFR message
      call codes_bufr_new_from_file(ifile, ibufr, iret)
 
      count = count + 1
 
   end do
 
   ! Close file
   call codes_close_file(ifile)
 
end program bufr_keys_iterator
