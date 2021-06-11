#!/bin/bash

# PARAMETER 1: Docker Hub Login
# PARAMETER 2: Docker Hub Password

if [[  $(docker images | grep 'netapp/trident' | grep 21.04.0 | wc -l) -ne 2 ]]
  then
    echo "########################################"
    echo "# PULLING TRIDENT IMAGES FROM DOCKER HUB"
    echo "########################################"

    docker login -u $1 -p $2
    docker pull netapp/trident:21.04.0
    docker pull netapp/trident-operator:21.04.0
    docker pull netapp/trident-autosupport:21.01
fi

echo "####################################"
echo "# TAGGING TRIDENT IMAGES"
echo "####################################"

docker tag netapp/trident:21.04.0 registry.demo.netapp.com/trident:21.04.0
docker tag netapp/trident-operator:21.04.0 registry.demo.netapp.com/trident-operator:21.04.0
docker tag netapp/trident-autosupport:21.01 registry.demo.netapp.com/trident-autosupport:21.01

echo "##########################################"
echo "# PUSHING TRIDENT IMAGES TO THE LOCAL REPO"
echo "###########################################"

docker push registry.demo.netapp.com/trident:21.04.0
docker push registry.demo.netapp.com/trident-operator:21.04.0
docker push registry.demo.netapp.com/trident-autosupport:21.01