FROM node:14-alpine3.10 as imageBuilder
WORKDIR /app
COPY . .
RUN npm ci --prod
RUN npm run build

FROM node:14-alpine3.10
COPY --from=imageBuilder /app/build/ app/build
WORKDIR /app
EXPOSE 3000
RUN npm install -g serve
CMD serve -p 3000 ./build