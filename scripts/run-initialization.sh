#!/bin/bash

/opt/mssql/bin/sqlservr &

pushd /usr/src/app/

./wait-for-db-up.sh

sleep 1

echo "Create the DB sample-db"
cat "/opt/sql/create-db.sql" | sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master

sleep 3

popd
