# Deployment in a Kubernetes Cluster

In each `yaml` file the namespace tag must be edited to the desired namespace to effectuate the deployments.

## Traefik Ingress

- Inside the `k3s/ingress` deploy the ingress:

    kubectl apply -f ingress.yaml -n gic6

## Nginx

- From the `k3s/nginx` directory, deploy the Nginx ConfigMap, apply the Persistance Volume Claim, the Service and the Deployment, with the following commands:

    kubectl apply -f nginx-config.yaml -n gic6

    kubectl apply -f nginx-pvc.yaml -n gic6

    kubectl apply -f nginx-service.yaml -n gic6

    kubectl apply -f nginx-deployment.yaml -n gic6


## Postgres

- Go to the `k3s/secrets` directory and deploy the Postgres Secrets. Then, inside the `postgres` folder, deploy the Persistance Volume Claim, the StatefulSet and a Service using the following commands:


    kubectl apply -f postgres-secrets.yaml -n gic6

    kubectl apply -f postgres-pvc.yaml -n gic6

    kubectl apply -f postgres-statefulset.yaml -n gic6

    kubectl apply -f postgres-service.yaml -n gic6


## Misago - Backend

- Build the docker image from the `Dockerfile` in the root folder.

    docker build -t registry.deti:5000/gic6-misago .

- Push misago image built from the dockerfile to a registry.

    docker push registry.deti:5000/gic6-misago


## Misago - Frontend

- Build the docker image from the `Dockerfile.frontend` in the root folder.

    docker build -f Dockerfile.frontend -t registry.deti:5000/gic6-misago-frontend .

- Push the built image from the to a registry.

    docker push registry.deti:5000/gic6-misago-frontend

Then, access the `k3s/frontend` directory and deploy the Service and Deployment to the namespace:

    kubectl apply -f misago-frontend-service.yaml -n gic6

    kubectl apply -f misago-frontend-deployment.yaml -n gic6



## Redis

- To create a Redis cluster with one master and two slaves, access the `k3s/redis` directory and deploy the redis ConfigMap, a StatefulSet and a Service using the following commands:

    kubectl apply -f redis-config.yaml -n gic6

    kubectl apply -f redis-statefulset.yaml -n gic6

    kubectl apply -f redis-service.yaml -n gic6
