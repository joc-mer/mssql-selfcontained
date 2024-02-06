# Docker self contained MSSQL DB

This project contains what's needed to build self-contained database based on MS SQL server Azure.

## Disclaimer
- This is for personnal **tests** only, the inserted **data will be lost once the container is stopped and removed**.
- This contains code forwarding your choice about the Microsoft's licence (`ACCEPT_EULA` argument). Using it implies to conform to the underlying licence.

## Principle

THe docker file is composed of 3 phases :
 - The installation of `sqlcmd`
 - The creation of the database with pre-inserted data
 - The copy of the data to a fresh image

## build

```shell
docker build . --build-arg="ACCEPT_EULA=1" --progress=plain -t self-contained-mssql
```

The password can be customized using the `MSSQL_SA_PASSWORD` build argument. Beware of the MS policy regarding the passwords.

## run

```shell
docker run -p 1433:1433 --name mssql-sample-db self-contained-mssql
```

## stop

```shell
docker stop mssql-sample-db
```
