#!/bin/bash

probe_db () {
  echo "USE [master];" | sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master > /dev/null
}

until probe_db
do
    echo "Waiting for MS SQL to be up..."
    sleep 10
done
