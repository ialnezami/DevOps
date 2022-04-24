#commande for docker
#pull container
docker pull $1
#run container
docker run -d -p $2:$3 $1
#stop container
docker stop $4
#remove container
docker rm $4
#remove image
docker rmi $1
#list container
docker ps -a
#list image
docker images
#list volume
docker volume ls
#list network
docker network ls
#list node
docker node ls
#list service
docker service ls
#list secret
docker secret ls
#list swarm
docker swarm ls
#list task
docker task ls
#list plugin
docker plugin ls
#list registry
docker registry ls
#copy file
docker cp $5:/$6 $7
#delete file
docker exec -it $4 rm -rf $6
#list file
docker exec -it $4 ls -l $6x
#to enter in shell mode
docker exec -it id_container sh
