CREATE DATABASE [sample-db]
GO

USE [sample-db];

CREATE TABLE BOOKS (
    ID varchar(32),
    NAME varchar(50),
    ISBN varchar(15)
);
GO

INSERT INTO BOOKS (ID, NAME, ISBN) VALUES ('abcv1234', 'Lord of the ring', '9780618343997');
GO
