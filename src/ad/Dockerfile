FROM eclipse-temurin:21-jdk AS builder

WORKDIR /usr/src/app/
# Can be skipped but it's a best practice because
# There all the commands of the dockerfile will be run

COPY gradlew* settings.gradle* build.gradle . 
# . = /usr/src/app/ 
# Copy all the gradle related files and we will download all
# the dependencies 

COPY ./gradle ./gradle 

RUN chmod +x ./gradlew
RUN ./gradlew downloadRepos 

# In this builder image we will download all the dependencies
# In step 2 image we will proceed with the build process
# The complete Gradle/Java project 

COPY . . 
COPY ./pb ./proto 
# The ./pb which has only one file is copied to the image as ./proto
# We replaced demo.proto file as .proto 

RUN chmod +x ./gradlew 
RUN ./gradlew installDist -PprotoSourceDir=./proto

#########################################

# The binary of Go is self contained hence which means that we can take the Go binary/exec and run in on the machine
# even if Go isn't installed that's because the container is self contained 
# That's why with Go it was possible to use alpine image
# If we want to use the same image we will need to install RUN JRE using curl or something like that.
# To avoid that we will need to find an image that has the JRE

FROM eclipse-temurin:21-jre 
# This image doesn't have the JDK but has the java runtime 
# So that makes the image lightweight 
# In the first stage we used the same image but with the JDK which makes the image a lot heavier
# Because we needed all the dependencies to build the application

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/ ./ 

ENV AD_PORT=9099

ENTRYPOINT ["./build/install/opentelemetry-demo-ad/bin/Ad"]

# When we will do docker run the executable will invoke the program 