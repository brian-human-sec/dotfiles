#!/bin/sh

docker build -t nginx-server .
docker stop nginx-server
docker rm -f nginx-server

echo running server on port 443
echo docker exec -it --user root nginx-server /bin/bash
echo docker logs nginx-server
if command -v docker-compose; then
  docker-compose up
else
  docker run --name=nginx-server -h nginx-server -h nginx-server --restart unless-stopped -p 443:443 -d nginx-server
fi

exit 0
