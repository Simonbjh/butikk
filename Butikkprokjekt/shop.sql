-- Demo database for testing of db-components
-- originally intended for Norwegian students
-- english names would be customer,product,order,detail

-- create role,database for demo

create role sjef password '123';              -- shop is user
alter role sjef with login;                          -- allow login
create database shop owner sjef ;                     -- create db



-- enter the new db
\c shop;


DROP TABLE IF EXISTS users cascade;
DROP TABLE IF EXISTS kunde cascade;
DROP TABLE IF EXISTS vare cascade;
DROP TABLE IF EXISTS bestilling cascade;
DROP TABLE IF EXISTS linje cascade;


-- not all users are customers
create table users (
    userid SERIAL PRIMARY KEY,
    username text unique not null,
    role text default 'user',
    password text not null
); 

-- customer
CREATE TABLE kunde (
  kundeid SERIAL PRIMARY KEY,
  fornavn text NOT NULL,
  etternavn text NOT NULL,
  adresse text,
  epost text,
  tlf text,
  kjonn text,
  userid int unique not null
);

-- product
CREATE TABLE  vare  (
   vareid  SERIAL PRIMARY KEY,
   navn  text NOT NULL,
   erkategori boolean,
   pris  int NOT NULL,
   kategoriid int
);

-- kategori
CREATE TABLE  kategori  (
   kategoriid  SERIAL PRIMARY KEY,
   navn  text NOT NULL
);

-- order
CREATE TABLE  bestilling  (
   bestillingid  SERIAL PRIMARY KEY,
   dato  date NOT NULL,
   kundeid  int NOT NULL
);

-- detail (line in order)
CREATE TABLE  linje  (
   linjeid  SERIAL PRIMARY KEY,
   antall  int DEFAULT 1,
   vareid  int NOT NULL,
   bestillingid  int NOT NULL
);

ALTER TABLE  bestilling  ADD FOREIGN KEY ( kundeid ) REFERENCES  kunde  ( kundeid );
ALTER TABLE  linje  ADD FOREIGN KEY ( bestillingid ) REFERENCES  bestilling  ( bestillingid );
ALTER TABLE  linje  ADD FOREIGN KEY ( vareid ) REFERENCES  vare  ( vareid );
ALTER TABLE  kunde  ADD FOREIGN KEY ( userid ) REFERENCES  users  ( userid );
ALTER TABLE  vare  ADD FOREIGN KEY ( kategoriid ) REFERENCES  kategori  ( kategoriid );

alter table bestilling owner to sjef;
alter table vare owner to sjef;
alter table kunde owner to sjef;
alter table linje owner to sjef;
alter table users owner to sjef;