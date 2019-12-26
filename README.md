# complexk8s


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

- Pod
- Deployment
- Service: Setup Networking in a kubernetes cluster.
    * ClusterIP: Expose a set of pods to other objects in the cluster.
    * NodePort: Expose a set of pods to the outside world (only good for dev purpose).
    * LoadBalancer: Legacy way of getting network traffic into a cluster.
    * Ingress: Expose a set of services to the outside world.
- Secret: securely store a piece of info in the cluster, such as DB pw.


## Commands

```shell script
kubectl get storageclass

kubectl describe storageclass

kubectl get pv

kubectl get pvc

kubectl create secret generic <secret_name> --from-literal key=value
kubectl create secret generic pgpassword --from-literal PGPASSWORD=***

kubectl get secrets
```
