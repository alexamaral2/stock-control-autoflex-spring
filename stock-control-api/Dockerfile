FROM maven:3.9.12-eclipse-temurin-25 AS build-cache
WORKDIR /work
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
RUN ./mvnw dependency:go-offline -B

FROM build-cache AS dev
WORKDIR /work

RUN apt-get update && apt-get install -y inotify-tools && rm -rf /var/lib/apt/lists/*

COPY src src
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]