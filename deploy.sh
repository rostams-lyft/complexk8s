# Build the images
docker build -t rostam63/multi-client -f ./client/Dockerfile ./client
docker build -t rostam63/multi-server -f ./server/Dockerfile ./server
docker build -t rostam63/multi-worker -f ./worker/Dockerfile ./worker

# Build the images
docker push rostam63/multi-client
docker push rostam63/multi-server
docker push rostam63/multi-worker

# K8S apply
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rostam63/multi-server
