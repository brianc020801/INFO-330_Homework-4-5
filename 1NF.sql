/* Create a table of split abilities */
CREATE TABLE IF NOT EXISTS split_abilities AS 
SELECT pokedex_number,
	trim(value, '[]''') AS abilities
FROM imported_pokemon_data,
	json_each('["' || replace(abilities, ', ', '","') || '"]')
WHERE abilities <> '';

/* Create the 1NF table*/
/* Primary key is pokedex_number */
CREATE TABLE IF NOT EXISTS first_NF(
  abilities TEXT,
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
  pokedex_number TEXT,
  sp_attack TEXT,
  sp_defense TEXT,
  speed TEXT,
  type1 TEXT,
  type2 TEXT,
  weight_kg TEXT,
  generation TEXT,
  is_legendary TEXT
);

/* Create a temp table to drop the original abilities column */
CREATE TABLE IF NOT EXISTS temp_table AS
SELECT * FROM imported_pokemon_data;

/* Drop the original abilities column*/
ALTER TABLE temp_table DROP COLUMN abilities;

/* Attach the split abilities table to the temp table to put into 1NF */
INSERT INTO first_NF 
SELECT DISTINCT sa.abilities, tt.* 
FROM temp_table AS tt, split_abilities as sa 
WHERE sa.pokedex_number = tt.pokedex_number;

/* Drop the temp table and the split abilities table */
DROP TABLE temp_table;
DROP TABLE split_abilities;