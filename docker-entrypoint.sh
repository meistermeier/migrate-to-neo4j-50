#!/bin/bash -eu

cat > temp_dump

neo4j-admin load --from=temp_dump &>/dev/null
neo4j-admin set-initial-password secret &>/dev/null

mkdir -p /var/lib/neo4j/logs/
touch /var/lib/neo4j/logs/neo4j.log
neo4j start --verbose &>/dev/null 

until (exec 3<>/dev/tcp/127.0.0.1/7687) &>/dev/null; do
  sleep 1s
done

neo4j-migrations-1.13.0/bin/neo4j-migrations --password=secret run --migration=file:///var/lib/neo4j/V1__replaceBTreeIndexes.xml>/dev/null 

neo4j stop &>/dev/null
neo4j-admin dump --to=new_dump &>/dev/null
cat new_dump
