#commande for docker-compose
#pull container
docker-compose pull
#run container
docker-compose up -d
#stop container
docker-compose stop
#remove container
docker-compose rm
#remove image
docker-compose rmi
#list container
docker-compose ps
#list image
docker-compose images
#list volume
docker-compose volume ls
#list network
docker-compose network ls
#list node
docker-compose node ls
#build image with all options
docker-compose build --no-cache --force-rm --pull --parallel --rm --timeout=30 --build-arg=http_proxy=$http_proxy --build-arg=https_proxy=$https_proxy --build-arg=ftp_proxy=$ftp_proxy --build-arg=no_proxy=$no_proxy --build-arg=HTTP_PROXY=$HTTP_PROXY --build-arg=HTTPS_PROXY=$HTTPS_PROXY --build-arg=FTP_PROXY=$FTP_PROXY --build-arg=NO_PROXY=$NO_PROXY

