docker build -t kanwarnitin/multi-client:latest -t kanwarnitin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kanwarnitin/multi-server:latest -t kanwarnitin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kanwarnitin/multi-worker:latest -t kanwarnitin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kanwarnitin/multi-client:latest
docker push kanwarnitin/multi-server:latest
docker push kanwarnitin/multi-worker:latest

docker push kanwarnitin/multi-client:$SHA
docker push kanwarnitin/multi-server:$SHA
docker push kanwarnitin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kanwarnitin/multi-server:$SHA
kubectl set image deployments/client-deployment client=kanwarnitin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kanwarnitin/multi-worker:$SHA
