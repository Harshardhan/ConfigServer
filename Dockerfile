# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests 

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/EurekaServerApp/target/EurekaServerApp-0.0.1-SNAPSHOT.jar EurekaServerApp.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "EurekaServerApp.jar"]
