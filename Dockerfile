FROM openjdk:21
COPY target/spring-boot-hello-world-1.0.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
