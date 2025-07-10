# Use the official Eclipse Temurin JDK 17 image as base
FROM eclipse-temurin:17-jdk

# Set working directory inside the container
WORKDIR /app

# Copy all files from your repo into the container
COPY . .

# Find and compile all Java files in current and subdirectories
RUN find . -name "*.java" > sources.txt && javac @sources.txt

# Run your bot starting with the App class
CMD ["java", "App"]