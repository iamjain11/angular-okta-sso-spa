# stage 1
FROM node:latest as node
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# stage 2
FROM nginx:alpine


# Remove the default nginx.conf
RUN rm -rf /usr/share/nginx/html/* && rm -rf /etc/nginx/nginx.conf

# Replace with our own nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=node /app/dist/angular-okta-spa-sso /usr/share/nginx/html