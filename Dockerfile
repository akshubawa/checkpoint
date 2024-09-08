FROM node:lts-alpine3.19

WORKDIR /app

# Copy package files and install npm dependencies
COPY backend/package*.json .
RUN npm install

# Copy the rest of the application files
COPY backend/ src/

# Build the application
RUN npm run build

# Start the application
CMD [ "npm", "start" ]