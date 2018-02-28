#!/bin/bash

# Initial setup script for macOS 10.12.x
#
# Immedeately lock the screen after the loginwindow was loaded. We do not want a user to login until firstboot script has finished and rebooted the device.

###############LOCK THE SCREEN##################
# Loop until the Loginwindow is up and running
until pid=$(pgrep -x "loginwindow" > /dev/null)
do 
echo "loginwindow not running"
sleep 1
done
echo "loginwindow is up and running, go on"

# Set the path of the Lockscreen image (Lock.jpg)
path=/private/var/Lockscreen

## Copy the lockscreen App to a folder we can write to (beacuse of SIP).
cp -r /System/Library/CoreServices/RemoteManagement/AppleVNCServer.bundle/Contents/Support/LockScreen.app $path/LockScreen.app

## Remove the big lock image
mv $path/LockScreen.app/Contents/Resources/Lock.jpg $path/LockScreen.app/Contents/Resources/Lock.jpg.backup

# Replace the big Lock.jpg with a custom image 
cp $path/Lock.jpg $path/LockScreen.app/Contents/Resources/Lock.jpg

## lock the screen
## use open to open the App, anything else will fail!
open $path/LockScreen.app

#sometimes the resolution of the screen changes, so reload the Lockscreen
for i in {1..3}
do
sleep 2
killall LockScreen
open $path/LockScreen.app
echo "Lockscreen $i reloaded"
done
###############LOCK THE SCREEN - DONE##################

###############FIRSTBOOT SCRIPT HERE###################
#
#
###############FIRSTBOOT SCRIPT DONE###################

# Remove setup LaunchDaemon item
rm /Library/LaunchDaemons/com.xxx.initialsetup.plist
rm -r /private/var/Lockscreen

# Reboot to give Casper Suite the chance to apply Managed Preferences before the system is used after imaging.
# reboot
shutdown -r +1

# Make script self-destruct
rm -rf $0
