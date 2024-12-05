FROM node:lts-alpine

WORKDIR /usr/src/app

COPY . .

RUN npm install -g pnpm
RUN pnpm install

EXPOSE 4040

CMD [ "pnpm", "run", "dev" ]