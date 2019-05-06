cd /home/app/ma/current

docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml rm -f -v
docker-compose -f docker-compose.production.yml build
docker-compose -f docker-compose.production.yml run --rm rails rake db:create
docker-compose -f docker-compose.production.yml run --rm rails rake db:migrate && rake assets:precompile
docker-compose -f docker-compose.production.yml run --rm rails rake assets:precompile
docker-compose -f docker-compose.production.yml run --rm rails rake db:seed
docker-compose -f docker-compose.production.yml stop
docker-compose -f docker-compose.production.yml up -d
sleep 5
docker ps