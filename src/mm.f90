program AlamoMovie

    use pbl_met
    
    implicit none
    
    ! Locals
    real(4)                      :: x, y, z
    real(4)                      :: q, t
    character(len=256)  :: sMovieListName
    character(len=256)  :: sSnapName
    character(len=256)  :: sOutImagesPath
    integer                     :: iRetCode
    
    ! Get parameters
    if(command_argument_count() /= 2) then
        print *, "mm - Movie maker for ALAMO model"
        print *
        print *, "Usage:"
        print *
        print *, "  ./mm <Snapshots_List_File> <Out_Images_Path>"
        print *
        print *, "by: Mauri Favaron"
        print *
        print *, "This is open-source software, part of the pbl_met project"
        print *
        stop
    end if
    call get_command_argument(1, sMovieListName)
    call get_command_argument(1, sOutImagesPath)

end program AlamoMovie
