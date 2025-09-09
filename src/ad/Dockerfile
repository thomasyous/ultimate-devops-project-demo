FROM eclipse-temurin:21-jdk AS builder

# Define the working directory inside the container
WORKDIR /usr/src/app/

# Copy Gradle wrapper and build files first (for better caching)
COPY gradlew* settings.gradle* build.gradle ./
COPY ./gradle ./gradle

# Ensure gradlew is executable
RUN chmod +x ./gradlew
RUN ./gradlew
RUN ./gradlew downloadRepos

# Copy the full source after dependencies to avoid invalidating cache early
COPY . .
COPY ./pb ./proto
RUN chmod +x ./gradlew

# Build the distribution
RUN ./gradlew installDist -PprotoSourceDir=./proto

#####################################################

FROM eclipse-temurin:21-jre

WORKDIR /usr/src/app/

# Copy only the built application from the builder stage
COPY --from=builder /usr/src/app/ ./

# Expose the port if you're using this in development/testing
ENV AD_PORT=9099

# Run the Ad service
ENTRYPOINT ["./build/install/opentelemetry-demo-ad/bin/Ad"]