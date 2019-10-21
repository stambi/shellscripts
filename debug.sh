# Log -x
time=$( date "+%d%m%y-%H%M" )
set -x
logfile=/var/log/PathToLogfile-"$time".log
exec > $logfile 2>&1
