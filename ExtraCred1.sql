/* Add mascot type*/
INSERT INTO types (type1, type2) VALUES ('mascot', '');

/* Make mascot type have no weaknesses*/
INSERT INTO type12_damage VALUES((SELECT id FROM types WHERE types.type1 = 'mascot'), 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

/* Add a Husky Pokemon classification*/
INSERT INTO classfications (classfication) VALUES('Husky Pokemon');

/* Add Huskichu to three_NF*/
INSERT INTO three_NF (attack, base_egg_steps, base_happiness, base_total, capture_rate, defense, experience_growth, height_m, hp, name, percentage_male, sp_attack, sp_defense, speed, weight_kg, classficationID, typeID, generationID, legendaryID)
VALUES (200, 30720, 0, 780, 3, 80, 1250000, 2.0, 110, 'Huskichu', 50, 140, 80, 170, 122.0, 589, 167, 7, 2);

/* Give Huskichu an ability */
INSERT INTO dexnumber_abilityID VALUES (802, 141);

/* Add a Cougar Pokemon classificaiton*/
INSERT INTO classfications (classfication) VALUES('Cougar Pokemon');

/* Add Cougarite to three_NF*/
INSERT INTO three_NF (attack, base_egg_steps, base_happiness, base_total, capture_rate, defense, experience_growth, height_m, hp, name, percentage_male, sp_attack, sp_defense, speed, weight_kg, classficationID, typeID, generationID, legendaryID)
VALUES (10, 30720, 0, 60, 3, 10, 1250000, 2.0, 10, 'Cougarite', 50, 10, 10, 10, 122.0, 590, 167, 7, 1);

/* Give Cougarite an ability */
INSERT INTO dexnumber_abilityID VALUES (803, 162);