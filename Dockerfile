#Dockerfile

# Use this image as the platform to build the app
FROM node:18-alpine AS external-website

# A small line inside the image to show who made it
LABEL Developers="Stars Beyond Devs"

# The WORKDIR instruction sets the working directory for everything that will happen next
WORKDIR /app

# Copy all local files into the image
COPY . .

# Avoid Vite permission error
RUN mkdir /app/node_modules/ || true
RUN mkdir /app/node_modules/.vite || true
RUN chown -R node:node /app/node_modules/.vite || true

# Clean install all node modules
RUN npm ci

#Fix permission errors for node
RUN chown -R node:node /app/
RUN chmod -R 777  /app/

# The USER instruction sets the user name to use as the default user for the remainder of the current stage
USER node:node

# This is the command that will be run inside the image when you tell Docker to start the container
CMD ["npm","run","start"]