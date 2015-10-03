@echo off
adb kill-server
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=allow
cls
echo.
set /p netname= Network Name:
netsh wlan set hostednetwork mode=allow SSID=%netname% 
echo.
set /p natpass= Network Password:
netsh wlan set hostednetwork key=%netpass%
netsh wlan start hostednetwork
echo --  Make sure the phone is connected to the computer via USB
set /p ok= --  Hit enter when phone is plugged in: 
adb usb
Timeout 10
adb tcpip 5555
cls
echo.
echo Now connect your phone to the "AndroidDev" network.
echo Use Settings-WiFi link to get the phone's NEW IP address
set /p phoneip= Enter the IP address here:  
adb connect %phoneip%
adb devices
set /p ok= Unplug the phone and hit Enter to see the final connection.
adb devices
Timeout 5
