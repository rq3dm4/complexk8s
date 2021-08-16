docker build -t USERNAME/multi-client:latest -t USERNAME/multi-client:$SHA -f ./client/Dockerfile ./client #variable $SHA comes from .tavis.yml
docker build -t USERNAME/multi-server:latest -t USERNAME/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t USERNAME/multi-worker:latest -t USERNAME/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push USERNAME/multi-client:latest
docker push USERNAME/multi-server:latest
docker push USERNAME/multi-worker:latest

docker push USERNAME/multi-client:$SHA
docker push USERNAME/multi-server:$SHA
docker push USERNAME/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=USERNAME/multi-server:$SHA
kubectl set image deployments/client-deployment server=USERNAME/multi-client:$SHA
kubectl set image deployments/worker-deployment server=USERNAME/multi-worker:$SHA