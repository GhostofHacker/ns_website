@echo off

rem Install dependencies and then build the frontend&backend

:setup_projects
echo Installing dependencies and building projects...
cd .\backend\
echo Installing backend dependencies.
call npm install
if %errorlevel% neq 0 (
    echo Failed to install backend dependencies.
    exit /b %errorlevel%
)
echo Creating backend .env file.
call npm run env
if %errorlevel% neq 0 (
    echo Failed to create .env file..
    exit /b %errorlevel%
)
echo Building Strapi.
call npm run build
if %errorlevel% neq 0 (
    echo Failed to build backend.
    exit /b %errorlevel%
)
cd ..

cd .\frontend\
echo Installing frontend dependencies.
call npm install
if %errorlevel% neq 0 (
    echo Failed to install frontend dependencies.
    exit /b %errorlevel%
)
echo Building Nextjs.
call npm run build
if %errorlevel% neq 0 (
    echo Failed to build frontend.
    exit /b %errorlevel%
)
cd ..

rem Build the docker image
:setup_docker
echo Building Docker Images.
call docker-compose build --no-cache
if %errorlevel% neq 0 (
    echo Failed to build the Docker images.
    exit /b %errorlevel%
)

echo Setup completed successfully!
echo Run Docker with docker-compose up
exit /b 0

