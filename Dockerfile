FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD
MAINTAINER Henry Akintoye

COPY pom.xml /build/

COPY src /build/src/

WORKDIR /build/
RUN mvn package -DskipTests

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=MAVEN_BUILD /build/target/SLMFrontendAPI.jar /app/

ENTRYPOINT ["java", "-jar", "SLMFrontendAPI.jar"]