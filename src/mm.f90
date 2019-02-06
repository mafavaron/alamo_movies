program AlamoMovie

    use pbl_met
    
    implicit none
    
    ! Locals
    real(4)                      :: x, y, z
    real(4)                      :: q, t
    character(len=256)  :: sMovieListName
    character(len=256)  :: sConfigName
    character(len=256)  :: sSnapName
    character(len=256)  :: sOutImagesPath
    character(len=256)  :: sBuffer
    integer                     :: iRetCode
    integer                     :: iPos
    real                          :: rXmin, rXmax, rYmin, rYmax, rZmin, rZmax
    real                          :: rDx, rDy
    real                          :: rMaxAge, rDeltaTime
    integer                     :: iYear, iMonth, iDay, iHour, iMinute
    real(8)                      :: rSecond
    
    ! Snapshot files directory
    integer                                                               :: iNumSnaps
    integer                                                               :: iSnap
    character(len=256), dimension(:), allocatable   :: svSnapDataFile
    
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
    
    ! Get name of data files to process
    iNumSnaps = 0
    open(10, file=sMovieListName, status='old', action='read', iostat=iRetCode)
    if(iRetCode /= 0) then
        print *, "Error: Snapshot list file not opened"
        stop
    end if
    do
        read(10, "(a)", iostat=iRetCode) sBuffer
        if(iRetCode /= 0) exit
        iNumSnaps = iNumSnaps + 1
    end do
    if(iNumSnaps <= 0) then
        print *, "Error: No snap data file to process"
        stop
    end if
    rewind(10)
    allocate(svSnapDataFile(iNumSnaps))
    do iSnap = 1, iNumSnaps
        read(10, "(a)") svSnapDataFile(iSnap)
    end do
    close(10)
    
    ! Deduce the configuration file name
    iPos = index(svSnapDataFile(1), "/", back=.true.)
    if(iPos <= 0) then
        sConfigName = "guide.txt"
    else
        sConfigName = svSnapDataFile(1)(1:(iPos-1)) // '/guide.txt'
    end if
    
    ! Read configuration
    open(10, file=sConfigName, status='old', action='read', iostat=iRetCode)
    if(iRetCode /=  0) then
        print *, "Error: Configuration file not found"
        stop
    end if
    read(10, *, iostat=iRetCode) &
        rXmin, rXmax, rYmin, rYmax, rZmin, rZmax, &
        rDx, rDy, rMaxAge, rDeltaTime,  &
        iYear, iMonth, iDay, iHour, iMinute, rSecond
    if(iRetCode /=  0) then
        print *, "Error: Invalid configuration file"
        stop
    end if
    close(10)

end program AlamoMovie
