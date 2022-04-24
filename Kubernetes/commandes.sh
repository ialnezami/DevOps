#kubernetes
#commande of kubectl
#apply yaml file
kubectl apply -f $1
# get all
kubectl get all
kubectl get nodes
#list pods
kubectl get pod -o wide
#list services
kubectl get service
#list replication controller
kubectl get rc
#delete yaml file
kubectl delete -f $1
#delete pod
kubectl delete pod $2
#delete service
kubectl delete service $3
#delete replication controller
kubectl delete rc $4
#delete node
kubectl delete node $5
#describe service
kubectl describe service $6
# see status autogenerated
kubectl get deployment container_name -o yaml | grep status
#namespace 
kubectl get namespace
#set active namespace
kubens mynamespace
#set default namespace
kubectl config set-context --current --namespace=default
#get ingress
kubectl get ingress -n kubernetes-dashboard --watch
#scale deployment
kubectl scale deployment $7 --replicas=2
#expos deployment
kubectl expose deployment $8 --port=80 --target-port=8080 --type=NodePort
#set image on pod
kubectl set image deployment $9 $9=image:tag