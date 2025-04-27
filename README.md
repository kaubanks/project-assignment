# Project Assignment: Docker Deployment

This repository contains a multi-container Docker environment used for deploying a web application. The project includes Dockerfiles, a `docker-compose.yml` file, and relevant configurations to build, run, and deploy the application on Docker.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Building Docker Images](#building-docker-images)
- [Deploying with Docker Compose](#deploying-with-docker-compose)
- [Troubleshooting](#troubleshooting)
- [Docker Hub Image Upload](#docker-hub-image-upload)

## Prerequisites

Before starting, ensure that you have Docker and Docker Compose installed on your local machine or server. If not, you can install them by following these steps:

- [Docker Installation](https://docs.docker.com/get-docker/)
- [Docker Compose Installation](https://docs.docker.com/compose/install/)

## Building Docker Images

1. Clone the repository:
    ```bash
    git clone https://github.com/kaubanks/project-assignment.git
    cd project-assignment
    ```

2. To build the Docker images locally, run the following command:
    ```bash
    sudo docker build -t project-assignment_web .
    ```

This will create the image for your web application, tagging it as `project-assignment_web:latest`.

## Deploying with Docker Compose

Docker Compose is used to manage multi-container Docker applications. We use a `docker-compose.yml` file to define and run the containers.

### Steps for Deployment:

1. Make sure your Docker Compose file is set up:
    ```yaml
    version: '3'
    services:
      web:
        build: .
        ports:
          - "5000:5000"
      postgres:
        image: postgres
        environment:
          POSTGRES_PASSWORD: example
    ```

2. Start the containers using Docker Compose:
    ```bash
    sudo docker-compose up -d
    ```

   - This command starts the containers in the background (`-d` flag).

3. To view the running containers:
    ```bash
    sudo docker ps
    ```

4. To stop the containers:
    ```bash
    sudo docker-compose down
    ```

## Troubleshooting

Here are some common issues you might encounter and their solutions:

### 1. **Permission Denied:**
   - **Issue:** If you see a permission denied error when interacting with Docker (`/var/run/docker.sock`), it means your user doesn't have the right permissions.
   - **Solution:** Add your user to the Docker group:
     ```bash
     sudo usermod -aG docker $USER
     ```

     Then log out and log back in to apply the changes.

### 2. **Access Denied When Pushing to Docker Hub:**
   - **Issue:** If you see a `denied: requested access to the resource is denied` error while trying to push images to Docker Hub.
   - **Solution:** Ensure you are logged into Docker Hub with the correct credentials:
     ```bash
     docker login
     ```
     If you're pushing to an organization's repository, ensure you have the necessary permissions.

### 3. **Docker Compose Command Not Found:**
   - **Issue:** If Docker Compose is not found.
   - **Solution:** Ensure Docker Compose is installed:
     ```bash
     sudo apt-get install docker-compose
     ```

## Docker Hub Image Upload

To upload the built Docker image to Docker Hub, follow these steps:

1. Tag the image:
    ```bash
    sudo docker tag project-assignment_web:latest kaubanks/project-assignment_web:latest
    ```

2. Push the image to Docker Hub:
    ```bash
    sudo docker push kaubanks/project-assignment_web:latest
    ```

   - This will upload the `project-assignment_web` image to your Docker Hub account under the `kaubanks` repository.

Once the image is pushed successfully, you can access it on Docker Hub at:  
[https://hub.docker.com/u/kaubanks](https://hub.docker.com/u/kaubanks)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
