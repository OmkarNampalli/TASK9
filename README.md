# TASK9
## Introduction to Docker (Containerization)

---

## What is docker and why is it used?
- **Docker** : Docker is a containirization tool which is used to create and manage containers.
- **Container**: A docker container is a running/working entity of an application. In other words a container contains all the neccessary environment, packages, resources that are required to run your application.
- **Image**: A docker image is a blueprint of a container. It contains all required information to create a docker container.
- **why is it used**:
  * When a developer devlops an application it runs on his device/system but if he gives same code or application to other devloper and it crashes or fails to run in other system/device.
  * So he packages or stores everything that is for his application to run successfully into a container.
  * Then the developer shares this container with other developer and this time the code runs succesfully.
  * Basically docker is like a operating system for containers. But Docker containers are isolated from the host OS.
  * This operating system can run any container that is created by it.
 
|Feature|Image (Stage 2)|Container (Stage 4)|
| :--- | :--- | :--- |
|State|Static / Frozen|Dynamic / Running|
|Mutability|Immutable (Read-Only)|Mutable (Writeable layer)|
|Analogy|A Cake Recipe|The Cake itself|
|Storage|Stored on disk|Running in memory (RAM)|
>Note: You will understand *Stage 2* / *Stage 4* in Image lifecycle section.

## Dockerfile
A **Dockerfile** is essentially a "recipe" or a blueprint. It is a simple text document that contains a list of instructions that Docker uses to automatically assemble a container image.

Instead of manually setting up an operating system, installing Node.js, and copying your files every time, you write those steps down in a Dockerfile, and Docker executes them for you.
### The Anatomy of a Dockerfile
A Dockerfile is made up of specific Instructions (usually in ALL CAPS) followed by Arguments. Here are the most common ones you'll see:
|Instruction|What it does|Real-world Analogy|
| :--- | :--- | :--- |
|`FROM`|"Sets the base image (e.g., Linux + Node.js)."|Choosing the type of crust for a pizza.|
|`WORKDIR`|"Sets the ""home"" folder inside the container."|Deciding which countertop to cook on.|
|`COPY`|Moves files from your computer into the image.|Putting your ingredients on that countertop.|
|`RUN`|Executes a command (like npm install).|Chopping the vegetables or boiling water.|
|`CMD`|The final command the container runs at the end.|Serving the pizza to the guest.|

## `docker build`
It is command used to build docker image with some features like provision of tag, author , etc.
The command used is: `docker build -t <tag-for-image> .`
- `-t` --> provide the tag given to image
- `.` --> build from current directory in which Dockerfile is located

## Run containers using images
The command used: `docker run -d -p 3000:3000 --rm --resstart always <image-id or image-name>`
- `-d` --> **detached mode** run the container in background or detach the container from current working shell.
- `-p 3000:80` --> **port binding** bind the port 3000 of host machine with port 80 of Container.
- `--rm` --> remove or delete the container when it is stopped
- `--restart always` --> run the container on boot.

## Managing Container and images
- To list images use : `docker images`
- To list running containers use : `docker ps`
- To list all containers use : `docker ps -a`
- To delete a image use : `docker rmi <image-id or image-name>`
- To Stop a container use : `docker stop <container-id or container-name>`
- To delete a container use : `docker rm <container-id or container-name>`

## Inspections of containers
Once your container is running, you need to be able to peek inside to see what's happening. Think of these commands as the "stethoscope" and "X-ray" for your Dockerized applications.

## 1. Seeing What's Running
Before you can inspect or view logs, you need the Container ID or Name.
- `docker ps`: Shows all currently running containers.
- `docker ps -a`: Shows all containers, including those that have crashed or exited.

## 2. Viewing Logs (docker logs)
Logs are the most common way to debug. Since Node.js applications usually output to `console.log`, Docker captures that as "STDOUT".

* **Basic Logs**: `docker logs [container_id]` Displays all logs generated since the container started.
* **Follow/Live Logs**: `docker logs -f [container_id]` Like `tail -f`; keeps the window open and updates in real-time as new logs arrive.
* **Timestamps**: `docker logs -t [container_id]` Adds a timestamp to every line—essential for debugging "when" a crash happened.
* **Tail X Lines**: `docker logs --tail 20 [container_id]` Shows only the last 20 lines (great for long-running apps).

## 3. Detailed Inspection (`docker inspect`)
If you need to know the technical "metadata" of the container (IP address, port mappings, environment variables, or volume mounts), use `inspect`.

`docker inspect [container_id]`

This returns a large JSON object. To find specific info without scrolling, you can use the `--format` flag:

- Find IP Address: `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [container_id]`

## 4. Interactive "Logging" (`docker exec`)
Sometimes looking at logs isn't enough; you need to "go inside" the container to look at files.

`docker exec -it [container_id] sh` >(Note: Use `bash` instead of `sh` if your base image supports it).

This drops you into a terminal inside the running container. You can then run `ls`, `pwd`, or check config files manually.

|Command|Purpose|Best Used When...|
|`docker ps`|List containers|You forgot the name of your container.|
|`docker logs -f`|Live stream logs|You are testing a new feature and want to see errors.|
|`docker inspect`|Full metadata|You need to find the internal IP or Mount points.|
|`docker stat`s|Live resource usage|You think your app is leaking memory (CPU/RAM).|
|`docker exe`c|Open terminal|You need to verify if a file was copied correctly.|
