FROM golang:alpine AS build-stage

RUN apk add git

WORKDIR /app

COPY . .

RUN go build -o /go/bin ./...

FROM alpine:latest

WORKDIR /app

COPY --from=build-stage /go/bin/ephemeral-notes .
COPY --from=build-stage /app/dist ./dist

ENTRYPOINT ["./ephemeral-notes"]