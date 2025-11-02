# 🧱 Base image
FROM openjdk:17-jdk-slim

# 🧰 Install necessary tools
RUN apt-get update && apt-get install -y git maven && rm -rf /var/lib/apt/lists/*

# 📁 Set working directory
WORKDIR /app

# 🧬 Clone your repo (optional if building locally)
# If you’re building from the cloned repo on your machine, you can skip this line
RUN git clone https://github.com/Prajna0106/Demo-project.git .
# If you already have local files, replace the line above with:
# COPY . .

# ⚙️ Build each Spring Boot microservice separately
RUN mvn -f eureka/pom.xml clean package -DskipTests && \
    mvn -f gateway/pom.xml clean package -DskipTests && \
    mvn -f first-service/pom.xml clean package -DskipTests && \
    mvn -f second-service/pom.xml clean package -DskipTests

# 🌐 Expose all ports
EXPOSE 8761 8765 8001 8002

# 🚀 Start all microservices together
CMD bash -c "\
  echo 'Starting Eureka Server...' && \
  java -jar eureka/target/*.jar & \
  sleep 10 && \
  echo 'Starting Gateway...' && \
  java -jar gateway/target/*.jar & \
  sleep 10 && \
  echo 'Starting First Service...' && \
  java -jar first-service/target/*.jar & \
  sleep 5 && \
  echo 'Starting Second Service...' && \
  java -jar second-service/target/*.jar & \
  wait"
