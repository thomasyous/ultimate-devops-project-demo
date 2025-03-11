FROM golang:1.22-alpine AS builder 
# We could've run this in a single stage we don't need FROM goland
# But it's a best practice (DevSecOps practice) to copy the binary to the second stage

WORKDIR /usr/src/app 
# Best practice to always choose the working directory 
# For this image the working directory is /usr/src/app  

COPY . . 

RUN go mod download
# Get's all the dependencies and binaries needed for the app (Written by developers) 

RUN go build -o /go/bin/product-catalog ./ 
# The directory doesn't matter because we will copy the binary into the release later
# A straight forward path like: product-catalog may even work faster. 

FROM alpine AS release 

# We can just run this binary at the entry point.
# Or we can also use cmd and just say within the cmd to execute this binary.
# But what we want is to follow the DevSecOps approach, and we want to use multi-stage Docker
# build, where in multi-stage Docker build, what we will do is we will create a new stage.
# In Linux, when you reduce unwanted binaries, shared libraries, the chance of vulnerabilities
# will significantly go down.
# That's why in the last stage of the multi-stage Docker build, we will use a very lightweight image
# which just has the basic system dependencies, no application dependencies, and you will copy the binary
# that we have created and just execute that binary. 
# No build in this stage, only copr the binary and execute it 

WORKDIR /usr/src/app 

COPY ./products ./products 
# Because the products binary is reading the products from ./products/products.json
# We will need to make sure we have it in the release image together with the binary. 

COPY --from=builder /go/bin/product-catalog ./ 
# Copy the binary from the builder image 

ENV PRODUCT_CATALOG_PORT=8088 
ENTRYPOINT ["./product-catalog"]