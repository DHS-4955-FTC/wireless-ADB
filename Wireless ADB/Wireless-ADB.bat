@rem
@echo off
setlocal EnableExtensions
goto check_Permissions

REM Code block that checks for administrative permissions.
:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        timeout 1
        goto intro_good
    ) else (
        cls
	echo.
        echo  --- Failure: Current permissions inadequate. ---
        echo.
	    echo          --- Hit enter to get help ---
	pause >nul
        goto intro_bad
    )

    pause >nul

REM Intro if "Wireless-ADB.bat" was "Run as administrator".
:intro_good
    cls
    echo.
    echo ############################################
    echo #                                          #
    echo # Hello! To start, please enter your name. #
    echo # If you want to skip, just hit Enter.     #
    echo #                                          #
    echo ############################################
    echo.
    goto user_name

REM Intro if "Wireless-ADB.bat" was run normally.
:intro_bad
    timeout 1
    echo.
    echo     ######################################
    echo     #                                    #
    echo     # The "Wireless-ADB.bat" was not run #
    echo     # with Administrative permissions.   #
    echo     #                                    #
    echo     ######################################
    echo.
    echo     ###   To "Run as administrator",   ###
    echo     ###    Follow the steps below.     ###
    echo.
    echo                   ~ Step 1 ~
    echo ------------------------------------------------
    echo Right Click on the "Wireless-ABD.bat" file.   
    echo ------------------------------------------------
    echo.
    echo                   ~ Step 2 ~
    echo ------------------------------------------------
    echo Move the cursor down to "Run as administrator"
    echo ------------------------------------------------
    echo.
    echo Note: For this to work, you must have Admin rights. 
    echo       You must either be loged in as Administrator,
    echo       or have the login info.
    echo.
    pause
    exit
    
 :user_name
   goto pick_path

:pick_path
   cls
   echo [Wireless ADB Programs] --------------------------------
   echo   1 -- Connect to phone with external router
   echo   2 -- Connect with Hosted Network
   echo   3 -- Hosted Network Setup
   echo   4 -- Help
   echo.  
   echo   4 -- Exit
   echo.
   set /P choiceADB="Enter a choice: "
   echo --------------------------------------------------------
   for %%I in (1 2 3 4 5 x) do if #%choiceADB%==#%%I goto choice%%I
   goto pick_path
   
:choice1
   cls
   echo.
   echo --  Starting ADB
   adb kill-server
   echo --  Make sure the phone is connected to the computer via USB
   set /p ok= --  Hit enter when phone is plugged in: 
   adb usb
   Timeout 10
   adb tcpip 5555
   echo.
   echo --  Make sure your phone ALSO is connected to the "Router" network.
   echo --  Click the Settings-WiFi link to get the first phone's IP address
   set /p phoneip="Enter the IP address here: "
   adb connect %phoneip%
   adb devices
   set /p ok= Unplug the phone and hit Enter to see the final connection.
   adb devices
   pause

   

:choice2
   cls
   echo.
   echo Choice 2!
   pause
   


:choice3
   cls
   echo.
   echo Choice 3
   pause
   


:choice4
   cls
   echo.
   echo Choice 4
   pause
  
