cd /home/app/ma/current

docker-compose -f docker-compose.production.yml down
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml run --rm rails rake assets:precompile && rake db:migrate
docker-compose -f docker-compose.production.yml down
docker-compose -f docker-compose.production.yml up -d
sleep 5
docker ps