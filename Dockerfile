# Stage 1: Build Tomcat
FROM alpine:latest AS builder
WORKDIR /usr/local
RUN apk add --no-cache wget && \
    wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.34/bin/apache-tomcat-10.1.34.tar.gz && \
    tar -xvzf apache-tomcat-10.1.34.tar.gz && \
    mv apache-tomcat-10.1.34 tomcat

# Stage 2: Run Tomcat
FROM openjdk:17-jdk-slim
WORKDIR /usr/local/tomcat
COPY --from=builder /usr/local/tomcat .
EXPOSE 8080
CMD ["bin/catalina.sh", "run"]
