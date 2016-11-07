if [ $# != 1 ]; then
	echo 'usage: kick_monitor.sh wo_path'
	exit 1
fi

cd $1

echo "= regenerator ==================================="
wo app rails r ./script/cache/regenerator.rb --worker=8

echo "= update.rb ==================================="
wo a be ruby script/adsvr/update.rb /home/ichiro.matsunaga/var/adsvr/adsvr.yml

