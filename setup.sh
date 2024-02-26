#!/bin/bash

#Error function
error() {
  echo "$@" 1>&2
  exit 1
}

# Install dependencies and then build the frontend&backend
setup_projects() {
    echo Installing dependencies and building projects...
    { # try
        cd backend
        echo Installing backend dependencies.
        npm install
    } || { # catch
        error "Failed to install backend dependencies."
    }

    { # try 
        echo Creating backend .env file.
        npm run env
    } || { # catch 
        error "Failed to create .env file."
    }

    { # try 
        echo Building Strapi.
        npm run build
    } || { # catch 
        error "Failed to build backend."
    }
    
    cd ..
    echo Installing frontend dependencies.
    
    { # try 
        cd frontend && npm install    
    } || { # catch 
        error "Failed to install frontend dependencies."
    }

    { # try 
        echo Building Nextjs.
        npm run build
    } || { # catch 
        error "Failed to build frontend."
    }
}

# Build the docker image
setup_docker() {
    { # try 
        echo Building Docker Images.
        docker-compose build --no-cache
    } || { # catch 
        error "Failed to build Docker images."
    }
}

# Combine both 
main() {
    setup_projects
    setup_docker
    echo Setup completed successfully!
    echo Run Docker with docker-compose up
    exit 0
}

#Run the complete setup
main