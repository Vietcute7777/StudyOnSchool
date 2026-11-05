# Stage 1: Build file .war bằng Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Chạy ứng dụng bằng Tomcat
FROM tomcat:9.0-jdk17-temurin
# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy file .war vừa build vào thư mục ROOT để truy cập trực tiếp từ trang chủ
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]