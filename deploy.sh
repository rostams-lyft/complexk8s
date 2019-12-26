# Build the images
# latest tag used in dev environment, $SHA tag gaurantees uniqueness in Prod environment
docker build -t rostam63/multi-client:latest -t rostam63/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rostam63/multi-server:latest -t rostam63/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rostam63/multi-worker:latest -t rostam63/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Build the images
docker push rostam63/multi-client:latest
docker push rostam63/multi-server:latest
docker push rostam63/multi-worker:latest

docker push rostam63/multi-client:$SHA
docker push rostam63/multi-server:$SHA
docker push rostam63/multi-worker:$SHA

# K8S apply
kubectl apply -f k8s

kubectl set image deployments/client-deployment client=rostam63/multi-client:$SHA
kubectl set image deployments/server-deployment server=rostam63/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rostam63/multi-worker:$SHA
