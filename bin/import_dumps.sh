cd ~/wo_docker/wo
id=$1
env=$2

echo "= import: $id ==========================="

wo db dropdb
wo db createdb && wo db import $id.$env
