( cd ~/var/adsvr/pushed/last/; rm -rf DEBUG Gemfile Makefile lib/ push.rb run  schedule test.rb tree/ )

tar zxvf ~/var/adsvr/pushed/last/push.msgpack.tgz -C  ~/var/adsvr/pushed/last/ > /dev/null 2>&1
cp ~/tmp/msgunpack.rb ~/wo_docker/wo/bin

wo a be ruby bin/msgunpack.rb $1 > /tmp/hoge.json

jq . < /tmp/hoge.json

exit

rm ~/wo_docker/wo/bin/msgunpack.rb
