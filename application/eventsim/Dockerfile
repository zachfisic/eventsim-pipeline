FROM sbtscala/scala-sbt:eclipse-temurin-jammy-8u352-b08_1.8.3_2.12.17 as builder
COPY ./src /opt/eventsim/src
COPY ./project /opt/eventsim/project
COPY ./build /opt/eventsim/build
# COPY assembly.sbt /opt/eventsim/
COPY build.sbt /opt/eventsim/
WORKDIR /opt/eventsim
RUN sbt assembly

FROM debian:stable-slim
WORKDIR /opt/eventsim
COPY --from=builder /opt/eventsim/target/scala-2.12/eventsim-assembly-2.0.jar ./

RUN apt-get update
RUN apt-get install wget curl -y
RUN apt-get install gnupg make gcc -y

# Install Java 8
RUN wget -q -O - https://download.bell-sw.com/pki/GPG-KEY-bellsoft |  apt-key add -
RUN echo "deb [arch=amd64] https://apt.bell-sw.com/ stable main" | tee /etc/apt/sources.list.d/bellsoft.list
RUN apt-get update
RUN apt-get install bellsoft-java8-lite -y

# Copy scripts
COPY config ./config
COPY data ./data
COPY --chmod=0755 eventsim.sh ./eventsim.sh
COPY --chmod=0755 entrypoint.sh ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
CMD ["config/example-config.json"]