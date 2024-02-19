FROM node:21

RUN mkdir -p /app
WORKDIR /app

COPY src /app
RUN npm install

ENTRYPOINT ["npm", "start"]