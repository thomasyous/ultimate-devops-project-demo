# This is Dockerfile for product0catalog service which is coded in go lang 
### Stage-1 ###
FROM golang:1.22-alpine AS builder
WORKDIR /usr/src/app

COPY . .
RUN go mod download
RUN go build -o product-catalog ./

### Stage-2 ###
FROM alpine AS release

WORKDIR /usr/src/app
COPY ./products ./products
COPY --from=builder /usr/src/app/product-catalog ./

ENV PRODUCT_CATALOG_PORT 8080
EXPOSE 8080
ENTRYPOINT ["./product-catalog"]

