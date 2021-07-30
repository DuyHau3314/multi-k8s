docker build -t hautdse05831/multi-client:latest -t hautdse05831/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hautdse05831/multi-server:latest -t hautdse05831/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hautdse05831/multi-worker:latest -t hautdse05831/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hautdse05831/multi-client:latest 
docker push hautdse05831/multi-server:latest
docker push hautdse05831/multi-worker:latest

docker push hautdse05831/multi-client:$SHA 
docker push hautdse05831/multi-server:$SHA
docker push hautdse05831/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hautdse05831/multi-server:$SHA
kubectl set image deployments/client-deployment client=hautdse05831/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hautdse05831/multi-worker:$SHA