#
# Build stage
#
FROM maven:3-openjdk-16-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:16-alpine
COPY --from=build /home/app/target/spring-drone-harness-0.0.1-SNAPSHOT.jar /usr/local/lib/spring-drone-harness.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/spring-drone-harness.jar"]