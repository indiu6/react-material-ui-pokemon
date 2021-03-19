# USE node 12 / STATE build files until next FROM
FROM node:12 as builder 

# working dir: /app
WORKDIR /app 

# copy package.json / package.lock.json 
COPY ./package*.json ./ 

# npm install
RUN npm install 

# copy all local files
COPY . . 

# build
RUN npm run build 

FROM nginx 
EXPOSE 3001

# COPY Local default.conf TO Docker /etc/nginx/conf.d/defalut.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf 

# COPY build file made from above TO /usr/share/nginx/html
COPY --from=builder /app/build  /usr/share/nginx/html 