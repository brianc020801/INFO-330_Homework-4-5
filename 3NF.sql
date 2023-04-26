/* 
Against types are dependent on typing, which is dependent on pokedex_number, therefor is a transitive dependent, so take them into another table
This code will list every combination of typing and put the damage columns in
*/
CREATE TABLE IF NOT EXISTS type12_damage AS
SELECT DISTINCT t.id, second_NF.against_bug, second_NF.against_dark, second_NF.against_dragon, second_NF.against_electric, second_NF.against_fairy, second_NF.against_fight, second_NF.against_fire, 
second_NF.against_flying, second_NF.against_ghost, second_NF.against_grass, second_NF.against_ground, second_NF.against_ice, second_NF.against_normal, second_NF.against_poison, second_NF.against_psychic, 
second_NF.against_rock, second_NF.against_steel, second_NF.against_water 
FROM types as t, second_NF
WHERE t.id = second_NF.typeID;


/* Keep everything else inside the table as 3NF */
CREATE TABLE IF NOT EXISTS three_NF(
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
  weight_kg TEXT,
  classficationID REFERENCES classfications,
  typeID REFERENCES types,
  generationID REFERENCES generations,
  legendaryID REFERENCES legendary
);

INSERT INTO three_NF SELECT * FROM second_NF;

/* Drop all damage columns */
ALTER TABLE three_NF DROP COLUMN against_bug;
ALTER TABLE three_NF DROP COLUMN against_dark;
ALTER TABLE three_NF DROP COLUMN against_dragon;
ALTER TABLE three_NF DROP COLUMN against_electric;
ALTER TABLE three_NF DROP COLUMN against_fairy;
ALTER TABLE three_NF DROP COLUMN against_fight;
ALTER TABLE three_NF DROP COLUMN against_fire;
ALTER TABLE three_NF DROP COLUMN against_flying;
ALTER TABLE three_NF DROP COLUMN against_ghost;
ALTER TABLE three_NF DROP COLUMN against_grass;
ALTER TABLE three_NF DROP COLUMN against_ground;
ALTER TABLE three_NF DROP COLUMN against_ice;
ALTER TABLE three_NF DROP COLUMN against_normal;
ALTER TABLE three_NF DROP COLUMN against_poison;
ALTER TABLE three_NF DROP COLUMN against_psychic;
ALTER TABLE three_NF DROP COLUMN against_rock;
ALTER TABLE three_NF DROP COLUMN against_steel;
ALTER TABLE three_NF DROP COLUMN against_water;

DROP TABLE second_NF;
