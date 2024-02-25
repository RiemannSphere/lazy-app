# Linux Ubuntu
FROM ubuntu:jammy
SHELL ["/bin/bash", "-c"] 

# System update
RUN apt-get update

# Install basic packages
RUN apt-get install -y curl git

# Install Go
RUN rm -rf /usr/local/go
RUN curl -L -O https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
RUN rm go1.22.0.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
RUN go version

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
RUN node -v

# Set app work directory
WORKDIR /home/app

# Frontend setup
RUN npx degit solidjs/templates/ts frontend-app
WORKDIR /home/app/frontend-app
RUN npm install

# Backend setup
WORKDIR /home/app/backend-app
RUN printf 'package main\n\
import "fmt"\n\
func main() { fmt.Println("Hello, World!")}' > main.go
RUN go fmt main.go

