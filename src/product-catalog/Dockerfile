# ------------ Stage 1: Build -------------
FROM golang:1.22-alpine AS builder

WORKDIR /usr/src/app

# Copy all source files
COPY . .

# Download dependencies (optional but recommended)
RUN go mod download

# Build the Go binary
RUN go build -o product-catalog ./


# ------------ Stage 2: Release -------------
FROM alpine AS release

WORKDIR /usr/src/app

# Copy products folder for JSON input
COPY ./products ./products

# Copy built binary from builder stage
COPY --from=builder /usr/src/app/product-catalog ./

# Set required environment variable
ENV PRODUCT_CATALOG_PORT=8088

# Start the application
ENTRYPOINT ["./product-catalog"]



