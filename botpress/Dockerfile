FROM node:8.12

WORKDIR /app

ADD package.json /app

RUN npm install --quiet

EXPOSE 3000

CMD ["npm", "start"]
