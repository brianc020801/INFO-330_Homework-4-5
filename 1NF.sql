CREATE TABLE split_abilities AS 
SELECT pokedex_number,
	trim(value, '[]''') AS abilities
FROM imported_pokemon_data,
	json_each('["' || replace(abilities, ', ', '","') || '"]')
WHERE abilities <> '';

CREATE TABLE temp_table AS
SELECT * 
FROM imported_pokemon_data;

ALTER TABLE temp_table DROP COLUMN abilities;

CREATE TABLE first_NF AS 
SELECT sa.abilities, tt.* 
FROM temp_table AS tt, split_abilities as sa 
WHERE sa.pokedex_number = tt.pokedex_number;

DROP TABLE temp_table;
DROP TABLE split_abilities;