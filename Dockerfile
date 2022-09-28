from neo4j:4.4

RUN apt update && apt install -y unzip
# Yes, this could be parameterized, but never change a running version ;)
RUN wget https://github.com/michael-simons/neo4j-migrations/releases/download/1.13.0/neo4j-migrations-1.13.0.zip
RUN unzip neo4j-migrations-1.13.0.zip

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
