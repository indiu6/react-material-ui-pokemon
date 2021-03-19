# practice dockerfile.dev
# FROM node:alpine

# WORKDIR /src/app

# COPY package.json ./

# RUN npm install

# COPY ./ ./

# CMD ["npm","run","start"]




# nginx가 제공을 해줄 빌드 파일들을 생성하는 코드

# node 12버젼사용 / build파일임을 명시
FROM node:12 as builder 

# working dir를 /app으로 설정
WORKDIR /app 

# 먼저 package.json/ package.lock.json 파일을 복사
COPY ./package*.json ./ 

# npm install
RUN npm install 

# 로컬에 있는 모든 파일을 복사
COPY . . 

# 빌드
RUN npm run build 

FROM nginx 
EXPOSE 3001

# 로컬에 있는 default.conf 파일을 도커 /etc/nginx/conf.d/defalut.conf로 복사
COPY ./default.conf /etc/nginx/conf.d/default.conf 

# 위에서 생성한 build 파일을 /usr/share/nginx/html로 복사
COPY --from=builder /app/build  /usr/share/nginx/html 