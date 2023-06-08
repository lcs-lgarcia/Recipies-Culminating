DELETE FROM Recipe;
DELETE FROM Ingridient;
-- item 1 in Recipes
INSERT INTO Recipe ('name', 'steps') VALUES ('Hot Chocolate', 'Boil water then add powder. Mix well.');
INSERT INTO Ingridient ('description', 'recipe_id') VALUES ('1 cup of water', 1);
INSERT INTO Ingridient ('description', 'recipe_id') VALUES ('3 tbsp of hot chocolate powder', 1);
