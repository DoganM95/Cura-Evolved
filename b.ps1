docker rm dc
docker rmi dc 

docker build -t dc .
docker run --rm --name dc -p 5800:5800 -p 5900:5900 dc #/bin/sh -c "while sleep 3600; do :; done"