from neo4j:4.4

RUN apt update && apt install -y unzip
# Yes, this could be parameterized, but never change a running version ;)
RUN wget https://github.com/michael-simons/neo4j-migrations/releases/download/1.13.0/neo4j-migrations-1.13.0-linux-x86_64.zip
RUN unzip -j neo4j-migrations-1.13.0-linux-x86_64 neo4j-migrations-1.13.0-linux-x86_64/bin/neo4j-migrations -d bin
RUN echo '<?xml version="1.0" encoding="UTF-8"?><migration xmlns="https://michael-simons.github.io/neo4j-migrations"><refactor type="migrate.replaceBTreeIndexes" /></migration>' > V1__replaceBTreeIndexes.xml

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
