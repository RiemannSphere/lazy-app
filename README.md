# Lazy App

This is a basic development setup for a "lazy app". What do we mean by "lazy"?
1. Write the setup once and use it many times. -> **Docker**
2. Avoid dependencies, avoid build, minification etc. Frontend code should "just work" in the browser. -> **buildless Solid.js**
3. Single binary for a backend service, simple to write and understand, powerfull standard library, easy deployment. -> **Go**
4. Easy and cheap deployment. -> **TO BE DECIDED**

# How to run

### Simplest Way
start it:\
`docker compose up -d`\
get inside:\
`docker exec -it lazy bash`\
kill it:\
`docker compose down`

or add these handy aliases to your `~/.bashrc`:
```bash
alias dup="docker compose up -d"
dsh() { docker exec -it $1 bash; }
alias ddo="docker compose down"
alias dcls="docker ps -a"
alias dils="docker images"
alias dcrm="docker ps -aq | xargs docker stop | xargs docker rm"
alias dirm="docker system prune -af"
```
then it becomes:\
`dup`\
`dsh lazy`\
`ddo`

### Frontend app
Inside the container `cd` into the frontend app directory and run:\
`pnpm run dev --host`\
The app will be available on `<container-IP>:3000`.

## Other Docker commands I always forget

### Build the image
`docker build -t lazy .`

### Run a container
`docker run --rm -it lazy`

### List containers
`docker ps -a`

### Remove container
`docker rm <name>`

### Remove all containers
`docker ps -aq | xargs docker stop | xargs docker rm`

### List images
`docker images`

### Remove all images
`docker system prune -a`
