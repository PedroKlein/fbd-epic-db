--view with prices with applied disount accourding to current date
CREATE VIEW discounted_prices AS
SELECT 
  region_id, 
  product_id, 
  CASE 
    WHEN discount IS NOT NULL AND CURRENT_TIMESTAMP >= (discount).start_date 
        AND CURRENT_TIMESTAMP <= (discount).end_date 
    THEN price * (1 - (discount).percentage) 
    ELSE price 
  END AS net_price,
  price,
  (discount).percentage as discount,
  (discount).end_date as end_date
FROM prices;

--select testUser1 library games
SELECT title, cover_img, favourite 
FROM users NATURAL JOIN library NATURAL JOIN games NATURAL JOIN products
WHERE user_id = 1;

-- List products that have the min value
SELECT title
FROM products NATURAL JOIN prices
WHERE price = (SELECT MIN(price) FROM prices)


-- consultas com groupby

-- List the number of products of which type listed in the catalog 
SELECT type, COUNT(product_id)
FROM products 
GROUP BY type
HAVING COUNT(product_id) > 0;

-- List users that have made at least one review
SELECT nickname, count(reviews)
FROM users NATURAL JOIN reviews
GROUP BY user_id
HAVING count(reviews) >= 1;


-- List products order by selling quantity of which region
SELECT game_id, name, count(*)
FROM users NATURAL JOIN regions NATURAL JOIN library
GROUP BY (name,game_id)
order by count(*) desc;

-- List titles that are listed as more than one type of product
SELECT COUNT(product_id), title 
FROM products 
GROUP BY title
HAVING COUNT(product_id) > 1;


-- List users that spent at least 50 dolars with products
SELECT user_id, nickname, sum(price) 
FROM users NATURAL JOIN library NATURAL JOIN games NATURAL JOIN products NATURAL JOIN prices
GROUP BY user_id
HAVING sum(price) > 50;


-- List user that have at least one game in their librarys
SELECT user_id, count(game_id) 
FROM users NATURAL JOIN library
GROUP BY user_id
HAVING COUNT(game_id) > 0;

-- queries com subqueries

-- List products that a user have that are more expensive than the average price of a game
SELECT nickname, title, price 
FROM users NATURAL JOIN library NATURAL JOIN games NATURAL JOIN products NATURAL JOIN prices
WHERE price > (SELECT avg(price) FROM prices);

-- List products that a user have that are more expensive than the average price of a game
SELECT nickname, title, price 
FROM users NATURAL JOIN library NATURAL JOIN games NATURAL JOIN products NATURAL JOIN prices
WHERE price > (SELECT avg(price) FROM prices);




SELECT 