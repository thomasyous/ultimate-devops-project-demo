#I have used this statement because this is is a multistage Dockerfile
#Please note Yash, that this is the syntax to name this file as Dockerfile and not anything else
#Multistage Docker build is the best practice of DevSecOps 
FROM golang:1.22-alpine AS builder

#WORKDIR is also not mandatory but its good practice to define where the docker files will be executed
#If not present it creates
WORKDIR /usr/src/app 

#COPY . . is a Dockerfile command which copied file from the machine to the Image
#The first . is the source and the second . is the destination
#First dot says take everything from the current from my computer that is the part of Docker build
#Second dot says place the files into current working directory in the image which is WORKDIR path 
COPY . .

#In Go Programming language there are 2 files which we need to run

# go mod download downloads all the go module required, its like saying it pulls all GO related dependencies into the container
RUN go mod download

#Compiles the GO code into binary executable and -o is the output path where the binary will be placed
# This binary becomes application which your container will be using
#at the end ./ is used to define or tell that the code is basically availabl;e in this directory
RUN go build -o product-catalog ./

#From here onwards the second and in this case the last stage of the multistage Dockerfile starts which needs to be the lightest one
#We are using alpine distribution because it it superlightweight Linux distribution 
#FROM is the keyword used at the start of the every stage
FROM alpine AS release

WORKDIR /usr/src/app

COPY ./products ./products

#Here we are not copying anything fromn the local direcroy but we are copying from different build stage from the same Dockerfile
#Thats why we are saying COPY --from=builder
COPY --from=builder /usr/src/app/product-catalog ./

#We ran PRODUCT_CATALOG_PORT=8088 earlier and hence here we are telling Docker that which port in application container listens on
ENV PRODUCT_CATALOG_PORT=8088 

#Defines the main process that should run when the process starts
#[./product-catalog] means that run the product-catalog binary located under WORKDIR inside the conatainer
ENTRYPOINT ["./product-catalog"]
