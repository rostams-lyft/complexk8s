# Sample K8s project
This project is a sample use-case of Kubernetes. At its core, it is simply a Fibonnaci calculator. It has three main components: server, client and worker. It uses redis as the in-memory store and postgres for the persistent layer. We intentionally made this complex architecture just to be a good sample for learning Kubernentes. For this reason, the Fibonnaci calculator is implemented recursively (notorious exponential time complexity) with the sole purpose of simulating a complex real system which requires a lot of processing.


## Architecture

![alt text](https://github.com/rostams-lyft/complexk8s/blob/master/images/architecture.png)

Please look at [k8s folder](https://github.com/rostams-lyft/complexk8s/tree/master/k8s) for configuration file associated with each of these components.

## Definitions

### Volume in Kubernetes

Volume in generic container terminology is some type of mechanism that allows a container to access a filesystem outside itself.

In Kubernetes, Volume is an object that allows a container to store data at the pod level.

Volume survives a container restart inside the pod. But if the pod itself dies/recreated/terminated/etc., the volume is gone. 
As a result of this, you can imagine why Volume object is not suitable for storing DB data.

###  Persistent Volume

If pod crashes, all the data inside it is lost. That is why we use a separate persistent volume on the host machine separate from the pod.

![alt text](https://github.com/rostams-lyft/complexk8s/blob/master/images/persistent_volume.png)


### PVC: Persistent Volume Claim
PVC is an advertised volume. It says here are the different options that you have for storing in this cluster.
When choosing one of those PVCs, then Kubernetes checks the readily available storage options.
If the volume is already available (created ahead of time), it is called Statically Provisioned Persistent Volume.
If the volume is not created ahead of time, it is called Dynamically Provisioned Persistent Volume.

### Types of objects in Kubernetes

- Pod: Run one or more closely related container.
- Deployment: Administers and manages a set of pods.
- Service: Setup Networking in a kubernetes cluster.
    * ClusterIP: Expose a set of pods to other objects in the cluster.
    * NodePort: Expose a set of pods to the outside world (only good for dev purpose).
    * LoadBalancer: Legacy way of getting network traffic into a cluster.
    * Ingress: Expose a set of services to the outside world.
- Secret: securely store a piece of info in the cluster, such as DB pw.


## Setting up [ingress-nginx](https://github.com/kubernetes/ingress-nginx)


## Kubernetes Commands

Here are some commonly used Kuberenetes command. Please find more commands here. 
Also, full Kubernetes documentation can be found here.

```shell script
kubectl get storageclass

kubectl describe storageclass

kubectl get pv

kubectl get pvc

kubectl create secret generic <secret_name> --from-literal key=value
kubectl create secret generic pgpassword --from-literal PGPASSWORD=***

kubectl get secrets

minikube dashboard
```

## Docker Commands

We'd wanted to run an instance of Ruby in a docker container and run a travis CLI on it to encrypt a GCP json file.
I found it useful to put the commands here for future reference.

```shell script

docker run -it -v $(pwd):/app ruby:2.3 sh
```
-it is for and -v is used to set the volume. $(pwd) is the present working directory of the repo to be mapped to app folder.
Folder name is chosen totally random. Then we use ruby 2.3 image and finally the command that we run is sh to start a shell.

```shell script
docker build -t rostam63/multi-client -f ./client/Dockerfile ./client
```
Build an image with a tag (-t), docker file location (-f), and specify build context (./client)

```shell script
docker push rostam63/multi-client
```
In order to push to docker hub.

The rest of the commands below are travis commands.
```shell script
gem install travis --no-rdoc --no-ri

gem install travis

travis login

copy json file to volumed (to be able to use it inside the container)

travis encrypt-file service-account.json -r rostams-lyft/complexk8s
```

## Git commands

```shell script
git rev-parse HEAD

git checkout <SHA>
```

## Google Cloud commands
These commands are used to set the project you are working on. These are also used in Travis.yaml file.

```shell script
gcloud config set project multi-k8s-263219

gcloud config set compute/zone us-west1-a

gcloud container clusters get-credentials multi-cluster
```
