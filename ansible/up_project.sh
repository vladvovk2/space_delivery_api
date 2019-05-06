cd /home/app/ma/current

docker-compose stop
docker-compose rm -f -v
docker-compose build
docker-compose run --rm rails rake assets:precompile && rake db:migrate
docker-compose stop
docker-compose up -d
sleep 5
docker ps