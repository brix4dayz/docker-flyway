FROM java:openjdk-8-jre

WORKDIR /flyway

ENV FLYWAY_VERSION 4.0.3

RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && ln -s /flyway/flyway /usr/local/bin/flyway

ENV MARIADB_CLIENT_VERSION 1.5.3

RUN curl -L http://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/${MARIADB_CLIENT_VERSION}/mariadb-java-client-${MARIADB_CLIENT_VERSION}.jar -o mariadb-java-client-${MARIADB_CLIENT_VERSION}.jar\
  && rm drivers/mariadb-java-client-*.jar \
  && mv mariadb-java-client-${MARIADB_CLIENT_VERSION}.jar drivers

ENV MYSQL_CONNECTOR_VERSION 5.1.39

RUN curl -L https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar -o mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar \
  && mv mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar drivers

#HEALTHCHECK CMD flyway -v | grep "Flyway $FLYWAY_VERSION by Boxfuse"

ENTRYPOINT ["flyway"]
CMD ["--help"]