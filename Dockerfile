FROM openjdk:11-jdk-slim
WORKDIR /app
COPY target/*.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
