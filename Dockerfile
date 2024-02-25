# Define OS version
ARG UBUNTU_VERSION=jammy

# OS setup
FROM ubuntu:$UBUNTU_VERSION
SHELL ["/bin/bash", "-c"]
RUN echo PS1=\"😪 \\W:$ \" >> ~/.bashrc

# Define dependency versions
ARG GOLANG_VERSION=1.22.0
ARG NODE_VERSION=20
ARG SOLIDJS_VERSION=1.8.15

# OS update
RUN apt-get update

# Install basic packages
RUN apt-get install -y curl git

# Install Go
RUN rm -rf /usr/local/go
RUN curl -L -O "https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz"
RUN tar -C /usr/local -xzf "go${GOLANG_VERSION}.linux-amd64.tar.gz"
RUN rm "go${GOLANG_VERSION}.linux-amd64.tar.gz"
ENV PATH="/usr/local/go/bin:${PATH}"
RUN go version

# Install Node
RUN curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash -
RUN apt-get install -y nodejs
RUN node -v

# Install pnpm
RUN npm install -g pnpm

# Set app work directory
WORKDIR /home/app

## Frontend setup
WORKDIR /home/app/frontend-app
COPY /frontend-app-template/ .

# Download Solid.js library
RUN mkdir solid-js
RUN curl -L "https://unpkg.com/solid-js@${SOLIDJS_VERSION}/dist/solid.js" --output /home/app/frontend-app/solid-js/solid.js
RUN curl -L "https://unpkg.com/solid-js@${SOLIDJS_VERSION}/web/dist/web.js" --output /home/app/frontend-app/solid-js/web.js
RUN curl -L "https://unpkg.com/solid-js@${SOLIDJS_VERSION}/html/dist/html.js" --output /home/app/frontend-app/solid-js/html.js

## Backend setup
WORKDIR /home/app/backend-app
COPY /backend-app-template/ .

WORKDIR /home/app
