docker build -t msheikhdocker/multi-client-k8s:latest -t msheikhdocker/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t msheikhdocker/multi-server-k8s-pgfix:latest -t msheikhdocker/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t msheikhdocker/multi-worker-k8s:latest -t msheikhdocker/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push msheikhdocker/multi-client-k8s:latest
docker push msheikhdocker/multi-server-k8s-pgfix:latest
docker push msheikhdocker/multi-worker-k8s:latest

docker push msheikhdocker/multi-client-k8s:$SHA
docker push msheikhdocker/multi-server-k8s-pgfix:$SHA
docker push msheikhdocker/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=msheikhdocker/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=msheikhdocker/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=msheikhdocker/multi-worker-k8s:$SHA