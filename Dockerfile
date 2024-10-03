<<<<<<< HEAD
# Specify the Node.js version to use
ARG NODE_VERSION=21
=======
FROM node:16-buster-slim
>>>>>>> parent of a6711ae (Update Dockerfile (#43))

RUN apt-get update && \
    apt-get install -y chromium traceroute && \
    chmod 755 /usr/bin/chromium && \
    rm -rf /var/lib/apt/lists/*

<<<<<<< HEAD
# Use Node.js Docker image as the base image, with specific Node and Debian versions
FROM node:${NODE_VERSION}-${DEBIAN_VERSION} AS build

# Set the container's default shell to Bash and enable some options
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

# Install Chromium browser and Download and verify Google Chrome’s signing key
RUN apt-get update -qq --fix-missing && \
    apt-get -qqy install --allow-unauthenticated gnupg wget && \
    wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt-get update -qq && \
    apt-get -qqy --no-install-recommends install chromium traceroute python make g++ && \
    rm -rf /var/lib/apt/lists/* 

# Run the Chromium browser's version command and redirect its output to the /etc/chromium-version file
RUN /usr/bin/chromium --no-sandbox --version > /etc/chromium-version

# Set the working directory to /app
=======
>>>>>>> parent of a6711ae (Update Dockerfile (#43))
WORKDIR /app

COPY package.json yarn.lock ./

<<<<<<< HEAD
# Run yarn install to install dependencies and clear yarn cache
RUN apt-get update && \
    yarn install --frozen-lockfile --network-timeout 100000 && \
=======
RUN yarn install && \
>>>>>>> parent of a6711ae (Update Dockerfile (#43))
    rm -rf /app/node_modules/.cache

COPY . .

<<<<<<< HEAD
# Run yarn build to build the application
RUN yarn build --production

# Final stage
FROM node:${NODE_VERSION}-${DEBIAN_VERSION}  AS final

WORKDIR /app

COPY package.json yarn.lock ./
COPY --from=build /app .

RUN apt-get update && \
    apt-get install -y --no-install-recommends chromium traceroute && \
    chmod 755 /usr/bin/chromium && \
    rm -rf /var/lib/apt/lists/* /app/node_modules/.cache
=======
RUN yarn build
>>>>>>> parent of a6711ae (Update Dockerfile (#43))

EXPOSE ${PORT:-3000}

ENV CHROME_PATH='/usr/bin/chromium'

<<<<<<< HEAD
# Define the command executed when the container starts and start the server.js of the Node.js application
CMD ["yarn", "start"]
=======
CMD ["yarn", "serve"]
>>>>>>> parent of a6711ae (Update Dockerfile (#43))
