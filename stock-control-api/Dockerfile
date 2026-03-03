FROM maven:3.9.12-eclipse-temurin-25 AS build-cache
WORKDIR /work
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
RUN ./mvnw -q -DskipTests dependency:go-offline

FROM build-cache AS dev
WORKDIR /work
COPY src src
EXPOSE 8080
CMD ["./mvnw", "spring-boot:run", "-Dspring-boot.run.jvmArguments=-Dserver.address=0.0.0.0"]

FROM build-cache AS build
WORKDIR /work
COPY src src
RUN ./mvnw -DskipTests clean package

FROM eclipse-temurin:25-jre AS prod
WORKDIR /app
COPY --from=build /work/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]