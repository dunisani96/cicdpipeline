FROM public.ecr.aws/docker/library/maven:3.9.11-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:resolve
COPY . /app
RUN mvn clean package -DskipTests

FROM public.ecr.aws/docker/library/eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]