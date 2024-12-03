FROM node:lts-alpine

WORKDIR /usr/src/app/frontend
COPY . .

RUN npm install -g pnpm
RUN pnpm install

EXPOSE 4040
CMD [ "pnpm", "run", "dev" ]