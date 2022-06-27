#!/bin/bash

# ingress
kubectl apply -f k3s/ingress/ingress.yaml -n gic6

# postgres
kubectl apply -f k3s/postgres/postgres-secrets.yaml -n gic6
kubectl apply -f k3s/postgres/postgres-pvc.yaml -n gic6
kubectl apply -f k3s/postgres/postgres-statefulset.yaml -n gic6
kubectl apply -f k3s/postgres/postgres-service.yaml -n gic6

# redis
kubectl apply -f k3s/redis/redis-config.yaml -n gic6
kubectl apply -f k3s/redis/redis-statefulset.yaml -n gic6
kubectl apply -f k3s/redis/redis-service.yaml -n gic6

# celery
kubectl apply -f k3s/celery/celery-deployment.yaml -gic6

# backend
kubectl apply -f k3s/misago/misago-config.yaml -n gic6
kubectl apply -f k3s/misago/misago-service.yaml -n gic6
kubectl apply -f k3s/misago/misago-deployment.yaml -n gic6

# frontend
kubectl apply -f k3s/frontend/misago-frontend-service.yaml -n gic6
kubectl apply -f k3s/frontend/misago-frontend-deployment.yaml -n gic6

# nginx 
kubectl apply -f k3s/nginx/exporter-config.yaml -n gic6
kubectl apply -f k3s/nginx/nginx-config.yaml -n gic6
kubectl apply -f k3s/nginx/nginx-pvc.yaml -n gic6
kubectl apply -f k3s/nginx/nginx-service.yaml -n gic6
kubectl apply -f k3s/nginx/nginx-deployment.yaml -n gic6

GET_PODS_OPTIONS='--no-headers -o custom-columns=:metadata.name --field-selector=status.phase==Running'

sleep 5

NGINX=
while [ -z "$NGINX" ]
do 
    NGINX=$(kubectl get pods $GET_PODS_OPTIONS -n gic6 | grep -m1 nginx)
    echo -ne "waiting for nginx to start running..."\\r
    sleep 1
done
echo "NGINX=$NGINX"

MISAGO=
while [ -z "$MISAGO" ]
do 
    MISAGO=$(kubectl get pods $GET_PODS_OPTIONS -n gic6 | grep -m1 misago)
    echo -ne "waiting for misago to start running..."\\r
    sleep 1
done
echo "MISAGO=$MISAGO"

kubectl exec -n gic6 -it $MISAGO -- /bin/bash -c "cp -r /srv/misago/misago/static/* /srv/misago/static/static && cp -r /srv/misago/promopage /srv/misago/static"
