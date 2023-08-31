docker rm dc
docker rmi dc 

docker build -t dc .
docker run --rm --name dc -p 5800:5800 -p 5900:5900 -v ".\volume\data:/config/xdg/data" -v ".\volume\config:/config/xdg/config" -v ".\volume\input:/app/input" -v ".\volume\output:/app/output" dc