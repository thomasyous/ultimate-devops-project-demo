FROM golang:1.22-alpine AS builder
WORKDIR /usr/src/app
COPY . .
RUN go mod download
RUN  go build -o product-catalog ./
FROM alpine AS release
WORKDIR /usr/src/app
COPY ./products ./products

COPY --from=builder /usr/src/app/product-catalog ./
EXPOSE ${PRODUCT_CATALOG_PORT}
ENTRYPOINT [ "./product-catalog" ]