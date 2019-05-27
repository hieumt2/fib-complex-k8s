docker build -t lionvnam/multi-client:latest -t lionvnam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lionvnam/multi-server:latest  -t lionvnam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lionvnam/multi-worker:latest -t lionvnam/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lionvnam/multi-client:latest
docker push lionvnam/multi-server:latest
docker push lionvnam/multi-worker:latest
docker push lionvnam/multi-client:$SHA
docker push lionvnam/multi-server:$SHA
docker push lionvnam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment web=lionvnam/multi-client:$SHA
kubectl set image deployments/server-deployment server=lionvnam/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lionvnam/multi-worker:$SHA