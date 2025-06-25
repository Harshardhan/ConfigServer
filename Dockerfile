# ===================== Stage 1: Build the application =====================
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set the working directory to project root
WORKDIR /app

# Copy only required files first for caching dependencies
COPY . .
# Pre-fetch dependencies
RUN ./mvnw dependency:go-offline -B

# Copy the entire project
COPY . .

RUN ./mvnw clean package -pl EurekaServerApp -am -DskipTests

# ===================== Stage 2: Run the application =====================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Create logs directory
RUN mkdir -p /app/logs

# Copy the built JAR
COPY --from=build /app/EurekaServerApp/target/*.jar EurekaServerApp.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "EurekaServerApp.jar"]
