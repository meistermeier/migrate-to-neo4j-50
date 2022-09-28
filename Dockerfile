ARG EDITION
from neo4j:4.4$EDITION

RUN apt update && apt install -y unzip
# Yes, this could be parameterized, but never change a running version ;)
RUN wget https://github.com/michael-simons/neo4j-migrations/releases/download/1.13.0/neo4j-migrations-1.13.0.zip
RUN unzip neo4j-migrations-1.13.0.zip
RUN echo '<?xml version="1.0" encoding="UTF-8"?><migration xmlns="https://michael-simons.github.io/neo4j-migrations"><refactor type="migrate.replaceBTreeIndexes" /></migration>' > V1__replaceBTreeIndexes.xml

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
