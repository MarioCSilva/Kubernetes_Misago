## Postgres

Go to the `k3s/secrets` directory and:

- Deploy Postgres Secrets:

    kubectl apply -f postgres-secrets.yaml

Then, inside the `postgres` folder:

- Deploy the Persistance Volume Claim:

    kubectl apply -f postgres-pvc.yaml

- Deploy the Stateful Set:

    kubectl apply -f postgres-statefulset.yaml

- Deploy the Service:

    kubectl apply -f postgres-service.yaml


## Misago - Django

- Build the docker image from the Dockerfile in the root folder.

    docker build -t registry.deti:5000/gic6-misago .

- Push misago image built from the dockerfile to a registry.

    docker push registry.deti:5000/gic6-misago



## Redis

### Note:

In each file the namespace tag must be edited to the desired namespace to effectuate the deployments.

To create a Redis cluster with one master and two slaves, access the `k3s/redis` directory, deploy the redis ConfigMap, a StatefulSet and a Service using the following commands:

    kubectl apply -f redis-config.yaml

    kubectl apply -f redis-statefulset.yaml

    kubectl apply -f redis-service.yaml
