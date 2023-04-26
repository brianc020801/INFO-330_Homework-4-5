/*The abilities depend on the pokemon, so seperate abilities into another table*/
CREATE TABLE IF NOT EXISTS abilities(
	id INTEGER PRIMARY KEY,
	ability TEXT UNIQUE 
);

INSERT INTO abilities (ability) SELECT DISTINCT abilities FROM first_NF;

/*The classification depend on the pokemon, so seperate classfication into another table*/
CREATE TABLE IF NOT EXISTS classfications(
	id INTEGER PRIMARY KEY,
	classfication TEXT UNIQUE 
);

INSERT INTO classfications (classfication) SELECT DISTINCT classfication FROM first_NF;

/*The types depend on the pokemon, so seperate type1 & type 2 into another table*/
CREATE TABLE IF NOT EXISTS types(
	id INTEGER PRIMARY KEY,
	type1 TEXT,
	type2 TEXT,
	UNIQUE(type1, type2)
);

INSERT INTO types (type1, type2) SELECT DISTINCT type1, type2 FROM first_NF;

/*The generation depend on the pokemon, so seperate generation into another table*/
CREATE TABLE IF NOT EXISTS generations(
	id INTEGER PRIMARY KEY,
	generation TEXT UNIQUE 
);

INSERT INTO generations (generation) SELECT DISTINCT generation FROM first_NF;

/*The legendary status depend on the pokemon, so seperate is_legendary into another table*/
CREATE TABLE IF NOT EXISTS legendary(
	id INTEGER PRIMARY KEY,
	is_legendary TEXT UNIQUE 
);

INSERT INTO legendary (is_legendary) SELECT DISTINCT is_legendary FROM first_NF;

/* Create a many to many relationship table between pokedex_number and ability id*/
CREATE TABLE IF NOT EXISTS dexnumber_abilityID(
	pokedex_number INTEGER,
	abilityID REFERENCES abilities,
	PRIMARY KEY(pokedex_number, abilityID)
);

INSERT INTO dexnumber_abilityID 
SELECT first_NF.pokedex_number, abilities.id 
FROM first_NF, abilities 
WHERE first_NF.abilities = abilities.ability;

/* Create the 2NF table*/
CREATE TABLE IF NOT EXISTS second_NF(
  against_bug TEXT,
  against_dark TEXT,
  against_dragon TEXT,
  against_electric TEXT,
  against_fairy TEXT,
  against_fight TEXT,
  against_fire TEXT,
  against_flying TEXT,
  against_ghost TEXT,
  against_grass TEXT,
  against_ground TEXT,
  against_ice TEXT,
  against_normal TEXT,
  against_poison TEXT,
  against_psychic TEXT,
  against_rock TEXT,
  against_steel TEXT,
  against_water TEXT,
  attack TEXT,
  base_egg_steps TEXT,
  base_happiness TEXT,
  base_total TEXT,
  capture_rate TEXT,
  classfication TEXT,
  defense TEXT,
  experience_growth TEXT,
  height_m TEXT,
  hp TEXT,
  name TEXT,
  percentage_male TEXT,
  pokedex_number INTEGER PRIMARY KEY,
  sp_attack TEXT,
  sp_defense TEXT,
  speed TEXT,
  type1 TEXT,
  type2 TEXT,
  weight_kg TEXT,
  generation TEXT,
  is_legendary TEXT,
  classficationID REFERENCES classfications,
  typeID REFERENCES types,
  generationID REFERENCES generations,
  legendaryID REFERENCES legendary
);

/* Create a temp table to drop the abilities before populating the 2NF table*/
CREATE TABLE IF NOT EXISTS temp_table AS
SELECT * FROM first_NF;

ALTER TABLE temp_table DROP COLUMN abilities;

/* Populate the 2NF table */
INSERT INTO second_NF 
SELECT DISTINCT tt.*, c.id, t.id, g.id, l.id
FROM temp_table AS tt, classfications AS c, types AS t, generations AS g, legendary AS l 
WHERE tt.classfication = c.classfication AND 
tt.type1 = t.type1 AND 
tt.type2 = t.type2 AND 
tt.generation = g.generation AND 
tt.is_legendary = l.is_legendary;

/* Drop columns that were separated into other tables */
ALTER TABLE second_NF DROP classfication;
ALTER TABLE second_NF DROP type1;
ALTER TABLE second_NF DROP type2;
ALTER TABLE second_NF DROP generation;
ALTER TABLE second_NF DROP is_legendary;

/* DROP first_nf and temp*/
DROP TABLE first_NF;
DROP TABLE temp_table;