# Neo4j 4.4 dump migration to 5.0

## Context
The _BTREE_ index type cannot get migrated to 5.0 on-the-fly.
This image and most of all the new support of migrating indexes in [Neo4j-Migrations](https://michael-simons.github.io/neo4j-migrations/current/) provides a one-liner to migrate your dumps from _BTREE_ to _RANGE_ indexes.

## Disclaimer
:warning: :warning: :warning: :warning: :warning:

The tool will convert **all** _BTREE_ indexes to _RANGE_ type.
It does not check if this is a _POINT_ or other type of index.
:underage: You might only use it if you know what you are doing.
:open_hands: This is for your from the community for the community.
I am happy to get your input if this helps you (or you have questions). But this Dockerfile is completely unofficial and unrelated to Neo4j.

:warning: :warning: :warning: :warning: :warning:

## Usage
From your Neo4j installation directory:

```
bin/neo4j stop
mkdir migration
bin/neo4j-admin dump --database=neo4j --to=migration/neo4j-with-btrees.dump
git clone git@github.com:meistermeier/migrate-to-neo4j-50.git migration/util
docker build -t neo4j-5.0-migration:1.0 migration/util
cat migration/neo4j-with-btrees.dump | docker run --rm -i neo4j-5.0-migration:1.0 > migration/neo4j-with-ranges.dump
bin/neo4j-admin load --force --database=neo4j --from=migration/neo4j-with-ranges.dump
bin/neo4j start
./bin/cypher-shell -u neo4j -p secret 'SHOW INDEXES' 
```

These steps:
* Create a migration director
* Dump your `neo4j` database
* Clone this utility 
* Build the container image locally
* Run and uses it
* Restores the database again
* Starts the server and shows that indexes are now of type `RANGE

Read more about _neo4j-admin_ and [Offline Backup](https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/),
read more about _neo4j-migrations_ [here](https://github.com/michael-simons/neo4j-migrations).

## Enterprise edition
If you need to, you can use the enterprise edition of Neo4j by providing `--build-arg EDITION="-enterprise"` during the image build.
By doing this, you accept the licencing of Neo4j enterprise edition.
