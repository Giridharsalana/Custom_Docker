#!/usr/bin/fish

docker login
docker -f ./Dockerfile_Main -t giridharsalana/gitpod_container:latest .
docker -f ./Dockerfile_Main_Full -t giridharsalana/gitpod_container_full:latest .
docker push giridharsalana/gitpod_container
docker push giridharsalana/gitpod_container_full
