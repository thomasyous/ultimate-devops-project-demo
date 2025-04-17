FROM eclipse-temurin:21-jdk AS builder

WORKDIR /usr/src/app
#Copy required files and folder to the image
COPY gradlew* settings.gradle* build.gradle .
COPY ./gradle ./gradle

#Giving permission to run ./gradlew and downloading the repo step by step

RUN chmod +x ./gradlew
RUN ./gradlew
RUN ./gradlew downloadRepos

#Copy the proto file which is better way to run the gradle file like the devs has given
COPY . .
COPY ./pb ./proto
RUN chmod +x ./gradlew

#NOW run the final cmd
RUN ./gradlew installDist -PprotoSourceDir=./proto

###################################################################################################################
#Second Stage of Docker Build 

FROM eclipse-temurin:21-jre

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app ./

ENV AD_PORT 9099

#######################################################################################################################



ENTRYPOINT ["./build/install/opentelemetry-demo-ad/bin/Ad"]


