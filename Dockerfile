# ---------- Stage 1: Build the application ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .  
RUN mvn clean install -DskipTests

# ---------- Stage 2: Run the application ----------
FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=builder /app/target/EurekaServerApp-0.0.1-SNAPSHOT.jar EurekaServerApp.jar
RUN mkdir -p logs

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "EurekaServerApp.jar"]
