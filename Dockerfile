FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app

# Copiar código
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src ./src

RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests spring-boot:repackage

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
