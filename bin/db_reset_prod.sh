cd ~/wo_docker/data

echo "kill db connect"
echo "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'weborder_development' AND pid <> pg_backend_pid();" \
	| psql -U weborder -h localhost weborder_development

id=$(ssh v-wodeploy1 'ls -t /mnt/data/weborder/dumps/dbdump-production-mini-schema-* | head -n 1')
id=$(echo ${id##*schema-})
id=$(echo ${id%%.dump})

files=("dbdump-production-mini-schema-" "dbdump-production-mini-" )
for f in ${files[@]}; do
	echo ${f}
	RSYNC_CONNECT_PROG='ssh -c arcfour' rsync -a --progress v-wodeploy1:/mnt/data/weborder/dumps/${f}${id}.dump ~/wo_docker/data/dumps/${f##*/}${id}.prod.dump
done

~/bin/import_dumps.sh ${id} prod

echo '= migrate ====================================='
cd ~/wo_docker/wo
wo a rake db:migrate


