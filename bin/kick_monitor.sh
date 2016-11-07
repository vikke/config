if [ $# != 1 ]; then
	echo 'usage: kick_monitor.sh wo_path'
	exit 1
fi

cd $1

#wo app rails r ./script/cache/regenerator.rb --worker=4 --types=constraint_js,creative_constraint
wo app rails r ./script/cache/regenerator.rb --worker=8
#wo a script push --order-ids=775
wo a be ruby script/adsvr/update.rb /home/ichiro.matsunaga/var/adsvr/adsvr.yml
wo a be ruby script/targeting_monitor/targeting_check.rb --debug --mute-slack --keyword=Infeed

