# build environment
FROM node:12.2.0-alpine as build
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package.json /usr/src/app/package.json
RUN apt-get update
RUN npm install
RUN npm install react-scripts@3.0.1 -g 
COPY . /usr/src/app/
RUN npm run build

# production environment
FROM nginx:1.16.0-alpine
COPY --from=build /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]