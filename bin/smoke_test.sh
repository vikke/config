#/bin/bash

if [ "$#" -ne "1" ]; then
	echo "1 - 3までの数値を指定してください。"
	exit 1
fi

echo "= drop & create ======================="
wo a -e smoke_test rake db:drop
wo a -e smoke_test rake db:create

echo "= schema load ========================="
SCHEMA=/var/hudson/jenkins_slave/rails4_schema_20160809044953.rb wo a -e smoke_test rake db:schema:load

echo "= migrate ============================="
wo a -e smoke_test rake db:migrate

echo "= data load ==========================="
wo a -e smoke_test rake spec:smoketest:data:load

echo "= run test ============================"
wo a -e smoke_test rake spec:smoketest:browse[${1}]

