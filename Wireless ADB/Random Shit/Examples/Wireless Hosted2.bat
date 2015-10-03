@rem ----[ This code block detects if the script is being running with admin PRIVILEGES If it isn't it pauses and then quits]-------
echo OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo.
) ELSE (
   echo.
   echo.
   cls
   echo ###################################################################### 
   echo #                                                                    #
   echo #      ########################################################      #
   echo #      #                                                      #      #
   echo #      #   ######## ########  ########   #######  ########    #      #
   echo #      #   ##       ##     ## ##     ## ##     ## ##     ##   #      #
   echo #      #   ##       ##     ## ##     ## ##     ## ##     ##   #      #
   echo #      #   ######   ########  ########  ##     ## ########    #      #
   echo #      #   ##       ##   ##   ##   ##   ##     ## ##   ##     #      #
   echo #      #   ##       ##    ##  ##    ##  ##     ## ##    ##    #      #
   echo #      #   ######## ##     ## ##     ##  #######  ##     ##   #      #
   echo #      #                                                      #      #
   echo #      ########################################################      #
   echo #                                                                    #
   echo #   ######### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED ###########   #
   echo #   #                                                            #   #
   echo #   #  This script must be run as administrator to work!         #   #
   echo #   #  To run as administrator, first you need to make sure      #   #
   echo #   #  you are logged in or have the login to the admin account. #   #
   echo #   #  Next, right click on the "Wireless_ADB.bat". Scroll       #   #
   echo #   #  down and select "Run As Administrator". If you have       #   #
   echo #   #  compleated the steps above, then you should no longer     #   #
   echo #   #  see this error.                                           #   #
   echo #   #                                                            #   #
   echo #   ##############################################################   #
   echo #                                                                    #
   echo ######################################################################
   echo.
   echo.
   PAUSE
   EXIT /B 1
)
@echo off
Title Wireless ADB
cls
echo.
echo ##########################################################
echo #                                                        # 
echo #      Administrator PRIVILEGES Detected, Good Job!      #
echo #                                                        #
echo ##########################################################
echo.
echo ##########################################################
echo #                                                        #
echo #   If you need any help, feel free to contact me at     #
echo #                "dyess.shaun@gmail.com"                 #
echo #                                                        #
echo ##########################################################
echo.
echo #####   Hit a key to continue or ctrl-z to cancel.   #####
echo.
pause >nul
goto simple
:simple
echo.
echo Just press enter if you dont know it.
set /p simple= Admin Password:
IF "%simple%" == "ShaunAllen" (
	goto simplerun
) ELSE (
	goto kill-111
)
:kill-111
echo loading. . .
adb kill-server
echo loading. . .
netsh wlan stop hostednetwork
echo loading. . .
netsh wlan set hostednetwork mode=allow
echo Done!
goto name
:name
cls
echo To continue, please enter your name.
set /p pername= -- Name:
IF "%pername%" == "" (
    set pername=User
	goto start
) ELSE (
	goto start
)
:end
echo.
echo  Hello %pername%! Thank you so much for using our program
echo for you FTC Wireless ADB needs. We at Dimond wish you good luck in
echo your wireless programing and debugging! 
echo.
echo -Dimond High Schools FTC/FRC Programing Team
echo.
:start
echo.
set /p ok= %pername%, please hit enter to continue...
goto SSID
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
set /p wifiname= -- %pername%, enter the name of the Hosted Network:
echo loading. . .
echo.
netsh wlan set hostednetwork SSID=%wifiname%
echo.
goto PassWord
:PassWord
cls
echo You have succeffuly set the Wireless Name to...
echo "%wifiname%"
echo.
echo ###########################################################
echo #                                                         #
echo #             Below you will set the password.            # 
echo #          Password MUST be 8 characters or more!         #
echo #                                                         #
echo ###########################################################
echo.
goto WifiPass
:WifiPass
set /p wifipass= -- %pername%, enter the password you want:
netsh wlan set hostednetwork key=%wifipass%
IF %ERRORLEVEL% == 0 (
    goto serverstart
) ELSE (
	cls
	goto WifiError
)
:WifiError
echo.
echo Im sorry %pername%, but you must chose a password that has
echo more then 8 characters. You cannot start the Hosted Network
echo if there is not atleast 8 characters.
echo.
set/p ok= Press Enter %parname% to change password...
cls
goto WifiPass
:serverstart
netsh wlan start hostednetwork
echo.
echo Now its time to bring the phone into the equation.
echo.
echo Connect your phone to the computer via the phones USB cable.
echo Before we continue, make sure the phone is turned on.
echo.
set /p ok= Once you're done %pername%, press enter...
echo.
echo Loading. . . 
adb usb
echo loading. . .
adb tcpip 5555
echo Done!
echo.
set /p ok= Press Enter to continue...
goto connectphone
:connectphone
cls
echo.
echo If you havent done it yet, unlock your phone and
echo navagate to the settings app. Once in there,
echo click the wifi tab.
echo.
echo Now connect the phone to the "%wifiname%".
echo Just as a reminder, the password you set is,
echo "%wifipass%"
echo.
echo For wireless ADB to work, it needs the phones
echo IP adress. The adress is found under the
echo "%wifiname%" tab. To see it, click the %wifiname%
echo tab and scroll down till you see the IP address.
echo Example IP Address: "192.168.1.133"
echo.
echo Once you have found it, enter it below...
set /p phoneip= IP address:  
adb tcpip 5555
adb connect %phoneip%
adb devices
set /p ok= --  Unplug the phone and hit Enter to see the final connection.
adb devices
set /p ok= You're done, now hit enter...
goto end
:simplerun
cls
echo.
echo Hello Shaun Dyess!