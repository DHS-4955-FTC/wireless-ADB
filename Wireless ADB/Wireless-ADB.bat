@REM
@echo off
setlocal EnableExtensions
goto check_Permissions

REM Code block that checks for administrative permissions.
:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto intro_good
    ) else (
        cls
        echo -------------------------------------------------------------------
        echo Failure: Current permissions inadequate.
        echo -------------------------------------------------------------------
        echo.
	      pause
        goto intro_bad
    )
rem test

REM Intro if "Wireless-ADB.bat" was "Run as administrator".
:intro_good
    cls
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
    cls
    echo              ######################################
    echo              #                                    #
    echo              # The "Wireless-ADB.bat" was not run #
    echo              # with Administrative permissions.   #
    echo              #                                    #
    echo              ######################################
    echo.
    echo              ###   To "Run as administrator",   ###
    echo              ###    Follow the steps below.     ###
    echo.
    echo                          ~ Step 1 ~
    echo -----------------------------------------------------------------------
    echo Right Click on the "Wireless-ABD.bat" file.
    echo -----------------------------------------------------------------------
    echo.
    echo                          ~ Step 2 ~
    echo -----------------------------------------------------------------------
    echo Move the cursor down to "Run as administrator"
    echo -----------------------------------------------------------------------
    echo.
    echo Note: For this to work, you must have Admin rights. That means,
    echo       you MUST be logged in as Administrator.
    echo.
    pause
    exit

:user_name
    set /p userName="Name: "
   goto pick_path

:pick_path
   cls
   echo [Wireless ADB Programs] ------------------------------------------------
   echo   1 -- Connect to phone with external router
   echo   2 -- Connect with Hosted Network
   echo   3 -- Hosted Network Setup
   echo   4 -- Help
   echo.
   echo   5 -- Exit
   echo.
   set /P choiceADB="Enter a choice: "
   echo ------------------------------------------------------------------------
   for %%I in (1 2 3 4 5 x) do if #%choiceADB%==#%%I goto choice%%I
   goto pick_path

:choice1
   cls
   echo ### Under Development ###
   echo.
   echo Going to Main Menu.........
   timeout 3
   goto pick_path

:choice2
   cls
   echo ### Under Development ###
   echo.
   echo Going to Main Menu.........
   timeout 3
   goto pick_path

:choice3
   cls
   echo.
   echo [Hosted Network Setup]--------------------------------------------------
   echo   1 -- Inital Setup
   echo   2 -- Set/Change Password
   echo   3 -- Set/Change Network Name [SSID]
   echo   4 -- View Current settings
   echo   5 -- Help
   echo.
   echo   6 -- Exit
   echo.
   set /P HNmenu="Enter a choice: "
   echo ------------------------------------------------------------------------
   for %%g in (1 2 3 4 5 6 x) do if #%HNmenu%==#%%g goto hnset%%g
   goto choice3

:hnset1
  cls
  echo.
  echo [Inital Hosted Network Setup]--------------------------------------------
  echo.
  echo   For your inital set up, we'll need 2 things...
  echo     1: A password that is strong. If its not strong, BAD things happen!
  echo     2: A network name [SSID] of your choosing.
  echo.
  set /p ok= -- Press Enter When Ready. . .
  goto WifiPass

:WifiPass
  echo.
  echo ###########################################################
  echo #                                                         #
  echo #             Below you will set the password.            #
  echo #          Password MUST be 8 characters or more!         #
  echo #                                                         #
  echo ###########################################################
  echo.
  set /p wifipass= -- Enter the password you want:
  netsh wlan set hostednetwork key=%wifipass%
  IF %ERRORLEVEL% == 0 (
      goto SSID
  ) ELSE (
  	cls
  	goto WifiError
  )
:WifiError
  echo.
  echo Im sorry, but you must chose a password that has
  echo more then 8 characters. You CANNOT start the Hosted Network
  echo if there is not at least 8 characters.
  echo.
  set/p ok= Press Enter to fix password. . .
  cls
  goto WifiPass

:SSID
  cls
  echo.
  echo ###########################################################
  echo #                                                         #
  echo #         Below you will name the Hosted Network.         #
  echo # This is what you'll see in the wifi menu of your phone. #
  echo #                                                         #
  echo ###########################################################
  echo.
  set /p wifiname= -- Enter the name of the Hosted Network:
  echo loading. . .
  echo.
  netsh wlan set hostednetwork SSID=%wifiname%
  echo.

:Pass-Name
  cls
  echo.
  echo -------------------------------------------------------------------------
  echo   Hit enter to review your password and SSID
  echo -------------------------------------------------------------------------
  pause
  echo Password Being Used:
  echo "%wifipass%"
  echo.
  echo SSID Being USed:
  echo "%wifiname%"
  echo.
  pause
  goto pick_path

:hnset2
  echo ###########################################################
  echo #                                                         #
  echo #             Below you will set the password.            #
  echo #          Password MUST be 8 characters or more!         #
  echo #                                                         #
  echo ###########################################################
  echo.
  set /p wifipass= -- Enter to change the Password:
  netsh wlan set hostednetwork key=%wifipass%
  IF %ERRORLEVEL% == 0 (
      goto choice3
      ) ELSE (
        cls
        goto WifiError2
      )

:WifiError2
  echo.
  echo Im sorry, but you must chose a password that has
  echo more then 8 characters. You CANNOT start the Hosted Network
  echo if there is not at least 8 characters.
  echo.
  set/p ok= Press Enter to fix password. . .
  cls
  goto hnset2


:choice4
   cls
   echo ### Under Development ###
   echo.
   echo Going to Main Menu.........
   timeout 3
   goto pick_path

:choice5
   goto _exit

:_exit
  pause
  cls
  echo -------------------------------------------------------------------------
  echo Here at Dimond Robotics, we strive to be the best. We want to say thank
  echo you for using our program for your Wireless ADB needs. Please respect
  echo us by not taking our code. We spent a lot of time to bring this to you.
  echo Eventually we will intergrate our code here into a more visual app.
  echo Basically, respect our copyright to this program. If there is any changes
  echo you want to make, make sure to some how credit us. We would love your
  echo feedback. Good luck, and happy programing!!!
  echo.
  echo -Dimond High School Programming Team
  echo -------------------------------------------------------------------------
  echo.
  PAUSE
  EXIT /B 1
