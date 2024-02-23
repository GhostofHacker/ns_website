FROM node:18-alpine

RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git

ENV NODE_ENV=development

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install -g node-gyp
RUN npm config set fetch-retry-maxtimeout 100000 -g && npm install
ENV PATH /app/node_modules/.bin:$PATH

WORKDIR /app

COPY . .

RUN chown -R node:node /app

USER node

RUN ["npm", "run", "build"]

EXPOSE 1339

CMD ["npm", "run", "develop"]