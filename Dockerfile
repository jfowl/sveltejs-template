FROM node:14-alpine as builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production ready serving via docker
FROM abdennour/nginx-distroless-unprivileged:latest as runner

WORKDIR /usr/share/nginx/html
COPY --from=builder  --chown=1001:0 /usr/src/app/public .

EXPOSE 8080
USER 1001
