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


