cd /home/app/ma/current

docker-compose -f docker-compose.yml stop
docker-compose -f docker-compose.yml rm -f -v
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml run backend rake assets:precompile && rake db:migrate
docker-compose -f docker-compose.yml stop
docker-compose -f docker-compose.yml up -d
sleep 5
docker ps