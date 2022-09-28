# Neo4j 4.4 dump migration to 5.0

## Context
The _BTREE_ index type cannot get migrated to 5.0 on-the-fly.
This image and most of all the new support of migrating indexes in [Neo4j-Migrations](https://michael-simons.github.io/neo4j-migrations/current/) provides a one-liner to migrate your dumps from _BTREE_ to _RANGE_ indexes.

## Disclaimer
The tool will convert **all** _BTREE_ indexes to _RANGE_ type.
It does not check if this is _POINT_ or other type of index.

## Usage
1. Prepare the dump via _neo4j-admin_: [Offline Backup](https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/)
2. Clone the repository
3. `cd` into the repository
4. Create the image: `docker build -t neo4j-5.0-migration:1.0 .`
5. Provide the dump (here named `dump`) and start a fresh container `cat dump | docker run --rm -i neo4j-5.0-migration:1.0 > new_dump`
6. The output `new_dump` will contain now the migrated indexes
7. Import the dump into 5.0 (or 4.4) and have fun ;)