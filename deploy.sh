docker build -t nkanwar/multi-client:latest -t nkanwar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nkanwar/multi-server:latest -t nkanwar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nkanwar/multi-worker:latest -t nkanwar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nkanwar/multi-client:latest
docker push nkanwar/multi-server:latest
docker push nkanwar/multi-worker:latest

docker push nkanwar/multi-client:$SHA
docker push nkanwar/multi-server:$SHA
docker push nkanwar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nkanwar/multi-server:$SHA
kubectl set image deployments/client-deployment client=nkanwar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nkanwar/multi-worker:$SHA
