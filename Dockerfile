FROM node:lts-alpine3.19 AS build

WORKDIR /app

COPY backend/package*.json ./
RUN npm install

COPY backend/ ./

RUN npm run build

FROM node:lts-alpine3.19

WORKDIR /app
EXPOSE 8080

COPY --from=build /app ./

# Ensure the index.js file is present
# {{ edit_1 }} - This line is optional if index.js is already included in the previous COPY command
# COPY backend/index.js ./  

RUN npm install --only=production

CMD [ "npm", "start" ]