# Set identity preference in Keychain for the logged in User
# STA / 23.05.2018
 
 
# Log -x
time=$( date "+%d%m%y-%H%M" )
set -x
logfile=/var/log/bla_identity_preference-"$time".log
exec > $logfile 2>&1
 
# identify logged-in user
loggedInUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
 
# get UID
loggedInUID=$(id -u "$loggedInUser")
 
#run as logged in UID
 
/bin/launchctl asuser "$loggedInUID" sudo -iu "$loggedInUser" /usr/bin/security set-identity-preference -c "$loggedInUser" -s https://url-you-want-to-set-the-if-pref-for.com
