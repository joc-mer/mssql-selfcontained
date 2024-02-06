FROM ubuntu:20.04 AS sqlcmd-installer

# Install sqlcmd
RUN apt-get update
RUN apt-get install -y curl wget software-properties-common
RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
RUN apt-get update
RUN apt-get install sqlcmd

# To build data files
FROM mcr.microsoft.com/azure-sql-edge:latest AS builder

COPY --from=sqlcmd-installer /usr/bin/sqlcmd /usr/bin/sqlcmd

# Create app directory
WORKDIR /usr/src/app

RUN mkdir -p /opt/sql
COPY ./sql-files /opt/sql

# Copy initialization scripts
COPY ./scripts /usr/src/app

# Long and complex enough password for MS policy
ARG MSSQL_SA_PASSWORD=root0fRoute!
ENV MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD}
ARG ACCEPT_EULA
ENV ACCEPT_EULA=${ACCEPT_EULA}

RUN /bin/bash /usr/src/app/run-initialization.sh

FROM mcr.microsoft.com/azure-sql-edge:latest

COPY --from=builder /var/opt/mssql/data /var/opt/mssql/data

ARG MSSQL_SA_PASSWORD=root0fRoute!
ENV MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD}
ARG ACCEPT_EULA
ENV ACCEPT_EULA=${ACCEPT_EULA}

EXPOSE 1433
