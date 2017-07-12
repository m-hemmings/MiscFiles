#!/bin/bash

mkdir -p ./jupyterhub/projects
docker pull deitrus/jupyterhub
docker run -d -p 80:8000 -v $(pwd)/jupyterhub/projects:/home/jupyterhub/projects deitrus/jupyterhub /home/jupyterhub/starthub.sh
 
