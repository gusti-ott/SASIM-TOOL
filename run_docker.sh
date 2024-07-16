#!/bin/bash

echo "killing old docker processes"
sudo docker-compose down

echo "pulling latest docker container"
sudo docker pull gusott/sasim:latest

echo "building docker containers and removing orphans"
docker-compose up -d --remove-orphans