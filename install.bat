@echo off

if not exist "topkeep.exe" (
    echo Could not find executable
    goto :END
)

if not exist "C:\Program Files\TopKeep" (
    echo Creating install directory
    mkdir "C:\Program Files\TopKeep"
)

if exist "C:\Program Files\TopKeep\topkeep.exe" (
    echo Deleting existing executable

    rem keep del silent by piping the stdout and stderr to NUL
    del "C:\Program Files\TopKeep\topkeep.exe" > NUL 2> NUL

    rem if it still exists then it must be locked
    if exist "C:\Program Files\TopKeep\topkeep.exe" (
        echo Could not delete, check that the program is not currently running
        goto :END
    )
)

rem keep copy silent by piping the stdout and stderr to NUL
copy /Y topkeep.exe "C:\Program Files\TopKeep\" > NUL 2> NUL

if exist "C:\Program Files\TopKeep\topkeep.exe" (
    echo Files copied successfully
)

echo Adding key to registry to run at startup

rem keep reg silent by piping the stdout and stderr to NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "TopKeep" /t REG_SZ /F /D "C:\Program Files\TopKeep\topkeep.exe" > NUL 2> NUL

echo Running TopKeep

rem finally run the program in the installed directory
start "" "C:\Program Files\TopKeep\topkeep.exe"

:END

pause
