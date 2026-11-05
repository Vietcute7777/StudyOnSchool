# Stage 1: Build file .war bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng bằng Tomcat
FROM tomcat:9.0-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*

# Tắt cổng shutdown của Tomcat để tránh nhận nhầm HTTP request/Health Check
RUN sed -i 's/<Server port="8005" shutdown="SHUTDOWN">/<Server port="-1" shutdown="SHUTDOWN">/' /usr/local/tomcat/conf/server.xml

# Copy file war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]