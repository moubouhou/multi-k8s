docker build -t multiple-client:latest ./client
docker build -t multiple-server:latest ./server
docker build -t multiple-worker:latest ./worker

docker build -t multiple-client:$SHA ./client
docker build -t multiple-server:$SHA ./server
docker build -t multiple-worker:$SHA ./worker
  
docker tag multiple-client:latest docker.io/$DOCKER_ID/multiple-client:latest
docker tag multiple-server:latest docker.io/$DOCKER_ID/multiple-server:latest
docker tag multiple-worker:latest docker.io/$DOCKER_ID/multiple-worker:latest

docker tag multiple-client:$SHA docker.io/$DOCKER_ID/multiple-client:$SHA
docker tag multiple-server:$SHA docker.io/$DOCKER_ID/multiple-server:$SHA
docker tag multiple-worker:$SHA docker.io/$DOCKER_ID/multiple-worker:$SHA

docker push docker.io/$DOCKER_ID/multiple-client:latest
docker push docker.io/$DOCKER_ID/multiple-server:latest
docker push docker.io/$DOCKER_ID/multiple-worker:latest

docker push docker.io/$DOCKER_ID/multiple-client:$SHA
docker push docker.io/$DOCKER_ID/multiple-server:$SHA
docker push docker.io/$DOCKER_ID/multiple-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=$DOCKER_ID/multiple-server:$SHA
kubectl set image deployment/client-deployment client=$DOCKER_ID/multiple-client:$SHA
kubectl set image deployment/worker-deployment worker=$DOCKER_ID/multiple-worker:$SHA



