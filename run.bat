echo "Create images...."

docker build -t c01 -f Dockerfile.c01 .
docker build -t c02 -f Dockerfile.c02 .
docker build -t c03 -f Dockerfile.c03 .
docker build -t proxy -f Dockerfile.proxy .

echo "Create network...."
docker network create -d bridge asa-net


echo "Delete/Create containers...."

docker stop c01
docker stop c02
docker stop c03
docker stop proxy

docker rm c01
docker rm c02
docker rm c03
docker rm proxy

echo "Create containers...."

docker run -d --net=asa-net --name c01 c01
docker run -d --net=asa-net --name c02 c02
docker run -d --net=asa-net --name c03 c03
docker run -dp 8000:80 --net=asa-net --name proxy proxy

echo "show containers...."

docker ps
