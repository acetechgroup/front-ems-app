#step 1: Build React App
FROM node:alpine3.19 as dist
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#step 2: Server with Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=dist /app/dist .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]