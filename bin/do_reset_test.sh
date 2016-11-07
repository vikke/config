wo d dropdb -d weborder_test
wo d createdb -d weborder_test

echo "# schema load #############################"
cp ../data/schema  db/schema.rb
#RAILS_ENV=test wo a rake db:schema:load
#export SCHEMA=db/rails4_schema_20160609

wo a rake db:schema:load RAILS_ENV=test
echo "# migration #############################"
wo a rake db:migrate RAILS_ENV=test


