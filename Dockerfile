# =========================
# Etapa de construcción
# =========================
FROM eclipse-temurin:21-jdk-alpine AS build

# Crear directorio de trabajo
WORKDIR /app

# Copiar Maven Wrapper y dar permisos de ejecución
COPY mvnw .
COPY .mvn .mvn
RUN chmod +x mvnw

# Copiar pom.xml e instalar dependencias
COPY pom.xml .
RUN ./mvnw dependency:go-offline

# Copiar código fuente
COPY src ./src

# Construir la app (sin tests para acelerar)
RUN ./mvnw clean package -DskipTests

# =========================
# Etapa de ejecución
# =========================
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app

# Copiar jar generado desde la etapa de build
COPY --from=build /app/target/*.jar app.jar

# Puerto que expondrá Render
EXPOSE 8080

# Variable de entorno para que Spring Boot use el puerto que Render asigna
ENV SERVER_PORT=8080

# Ejecutar la app
ENTRYPOINT ["java","-jar","app.jar"]
