# Stage 1: Build the app with Maven
FROM maven:3.8.7-eclipse-temurin-17 AS build

WORKDIR /app

# Copy only the pom.xml first (for dependency caching)
COPY pom.xml .

# Download dependencies (cache this layer)
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Package the app (compile and build the jar)
RUN mvn clean package

# Stage 2: Run the built jar
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar ./app.jar

# Run the jar
CMD ["java", "-jar", "app.jar"]