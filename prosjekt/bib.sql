CREATE TABLE "bruker" (
  "brukerid" SERIAL PRIMARY KEY,
  "fornavn" text NOT NULL,
  "etternavn" text NOT NULL,
  "adresse" text,
  "epost" text,
  "tlf" text,
  "kjonn" text
);

CREATE TABLE "produsent" (
  "produsentid" SERIAL PRIMARY KEY,
  "produsentnavn" text NOT NULL,
  "..dato" date,
  "land" text
);

CREATE TABLE "produkt" (
  "produktid" SERIAL PRIMARY KEY,
  "produktnavn" text NOT NULL,
  "lanseringsdato" date,
  "kategori" text,
  "pris" text,
  "produsentid" int
);

CREATE TABLE "vare" (
  "vareid" SERIAL PRIMARY KEY,
  "tillstand" text,
  "produktid" int
);

CREATE TABLE "kjop" (
  "kjopid" SERIAL PRIMARY KEY,
  "dato" date,
  "brukerid" int,
  "vareid" int
);

CREATE TABLE "linje" (
  "linjeid" SERIAL PRIMARY KEY,
  "antall" int,
  "kjopid" int,
  "vareid" int
);

ALTER TABLE "produkt" ADD FOREIGN KEY ("produsentid") REFERENCES "produsent" ("produsentid");

ALTER TABLE "vare" ADD FOREIGN KEY ("produktid") REFERENCES "produkt" ("produsentid");

ALTER TABLE "kjop" ADD FOREIGN KEY ("brukerid") REFERENCES "bruker" ("brukerid");

ALTER TABLE "linje" ADD FOREIGN KEY ("kjopid") REFERENCES "kjop" ("kjopid");

ALTER TABLE "linje" ADD FOREIGN KEY ("vareid") REFERENCES "vare" ("vareid");