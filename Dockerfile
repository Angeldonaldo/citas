# Etapa 1: Build con Maven y JDK 21
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

# Copia todo el proyecto
COPY . .

# Compila el proyecto (genera target/*.jar)
RUN ./mvnw clean package -DskipTests

# Etapa 2: Runtime liviano
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copiar el jar desde la etapa de build
COPY --from=builder /app/target/*.jar app.jar

# Puerto de Spring Boot
EXPOSE 8080

# Arranque de la aplicación
ENTRYPOINT ["java","-jar","/app/app.jar"]
