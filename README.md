# Docker_Demos

FROM maven:latest
COPY . /build
WORKDIR /build
RUN mvn clean package --no-transfer-progress


FROM openjdk:11
WORKDIR /opt
COPY --from=0 /build/target/Garage-0.0.1-SNAPSHOT.jar app.jar


ENTRYPOINT ["java", "-jar", "app.jar"]