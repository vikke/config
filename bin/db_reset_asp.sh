set -e

cd ~/wo_docker/data

echo 'dumping db'
ssh asp-rc './dump-mini.sh'

echo "kill db connect"
echo "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'weborder_development' AND pid <> pg_backend_pid();" \
	| psql -U weborder -h localhost weborder_development

id=$(ssh asp-rc 'ls -t ~/dumps/dbdump-production-mini-schema-* | head -n 1')
id=$(echo ${id##*schema-})
id=$(echo ${id%%.dump})

files=("dbdump-production-mini-schema-" "dbdump-production-mini-" )
for f in ${files[@]}; do
	echo ${f}
	RSYNC_CONNECT_PROG='ssh -c arcfour' rsync -a --progress asp-rc:~/dumps/${f}${id}.dump ~/wo_docker/data/dumps/${f##*/}${id}.asp.dump
done

~/bin/import_dumps.sh ${id} asp

MIG_FILE=~/wo_docker/wo/db/migrate/20180901061942_update_key_unique_record.rb
MIG_FILE_VIEW=~/wo_docker/wo/db/migrate/20180901061943_select_update_key.rb
trap cleanup INT TERM EXIT

cat << MIG > $MIG_FILE
class UpdateKeyUniqueRecord < ActiveRecord::Migration

  def up
    puts "#{KeyUniqueRecord.where(key: "TargetingCheck.adsvrs").first.content} => wodev05.dev.scaleouat.jp"

    KeyUniqueRecord.where(key: "TargetingCheck.adsvrs").first.tap do |cont|
      cont.content = 'wodev05.dev.scaleouat.jp'
      cont.save
    end
  end

  def down
    puts "#{KeyUniqueRecord.where(key: "TargetingCheck.adsvrs").first.content} => v251.dev.scaleout.jp"

    KeyUniqueRecord.where(key: "TargetingCheck.adsvrs").first.tap do |cont|
      cont.content = 'v251.dev.scaleout.jp'
      cont.save
    end
  end

end
MIG

cat << MIG > $MIG_FILE_VIEW
class SelectUpdateKey < ActiveRecord::Migration
  def up
    puts KeyUniqueRecord.where(key: "TargetingCheck.adsvrs").first.content
  end

  def down
    puts KeyUniqueRecord.where(key: "TargetingCheck.adsvrs").first.content
  end

end
MIG

echo '= migrate ====================================='
cd ~/wo_docker/wo
wo a rake db:migrate:up VERSION=20180901061942
#wo a rake db:migrate:up VERSION=20180901061943
wo a rake db:migrate

function cleanup(){
	echo 'clean'
	rm $MIG_FILE
	rm $MIG_FILE_VIEW
}
