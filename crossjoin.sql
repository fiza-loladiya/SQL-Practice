##cross join means muliply 2 table with each other.we don't have a common coloum in both table
SELECT * , 
concat(name," ",variant_name) as full_name,
 (price+variant_price) as full_price
FROM food_db.items
cross join food_db.variants;