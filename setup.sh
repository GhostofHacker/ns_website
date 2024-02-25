#!/bin/bash

# Install dependencies and then build the frontend&backend
setup_projects() {
    echo cd backend\ && npm install && npm run env && npm run build
    echo cd ..
    echo cd frontend\ && npm install && npm run build
}

# Build the docker image
setup_docker() {
    docker-compose build --no-cache
}

# Combine both 
main() {
    setup_projects
    setup_docker
}

#Run the complete setup
main