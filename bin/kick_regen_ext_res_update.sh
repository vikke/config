if [ $# -lt 1 ]; then
	echo 'usage: kick_monitor.sh wo_path [schedule-ids]'
	exit 1
fi

cd $1
if [ -z "${2}" ]; then
	wo a scr push --schedule-ids 6749,6777
else
	wo a scr push --schedule-ids $@
fi

echo "reload maiha tool"
wo snap reload

