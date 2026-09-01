FROM node:24.18.1-alpine3.23 AS build

WORKDIR /app

COPY server/package*.json ./
RUN npm ci --omit=dev

COPY server/index.js ./

FROM gcr.io/distroless/nodejs24-debian13:nonroot

WORKDIR /app

COPY --from=build --chown=nonroot:nonroot /app ./

EXPOSE 8090

CMD ["index.js"]
