cd /home/app/ma/current

docker-compose -f docker-compose.production stop
docker-compose -f docker-compose.production rm -f -v
docker-compose -f docker-compose.production build
docker-compose -f docker-compose.production run backend rake assets:precompile && rake db:migrate
docker-compose -f docker-compose.production stop
docker-compose -f docker-compose.production up -d
sleep 5
docker ps