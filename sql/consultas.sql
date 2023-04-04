--view with prices with applied discount accourding to current date
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

--procedure insert purchased game in library
create or replace function library_insertion_procedure()
RETURNS TRIGGER
language plpgsql
as $$
declare
   _game_id int;
begin
    IF (NEW.TYPE = 'GAME') THEN
                    SELECT g.game_id INTO _game_id  FROM games g WHERE g.product_id= NEW.product_id;
            INSERT INTO 
                    library (user_id, _game_id, favourite)
                    VALUES
                    (NEW.user_id, game, false);
                END IF;

    commit;
end;$$

--trigger when insert in purchase
CREATE TRIGGER library_insertion_trigger
AFTER INSERT ON Purchases
FOR EACH ROW
EXECUTE PROCEDURE library_insertion_procedure();

--select games with avarage rating above 7
--with group by and having
select g.game_id, p.product_id, p.title, avg(r.rating) as average from games g
natural join reviews r
natural join products p
group by g.game_id, p.product_id, p.title
having avg(r.rating) > 7;

--top seller products in each region
--with group  by and subquery
select r.region_id, r.name, p.product_id, p.title
from regions r
JOIN products p ON  p.product_id = (
		select pu.product_id
		from purchases pu
		natural join users u
		where u.region_id = r.region_id
		group by pu.product_id, u.region_id
		order by count(*) desc
		LIMIT 1);

--users that  didnt bought anything in the last month
--with not exists
select u.user_id, u.nickname, r.region_id, r.name
from users u
natural join regions r
where not exists (
	select user_id from purchases
	where purchase_date > CURRENT_TIMESTAMP - interval '1 month' and user_id = u.user_id);

--select user_id 1 library games
SELECT title, cover_img, favourite 
FROM users NATURAL JOIN library NATURAL JOIN games NATURAL JOIN products
WHERE user_id = 1;

--get percetage of users that completed each achievement from game_id 1 
--with subquery
select a.name, count(*)::decimal/sub.total as percentage
from achievements a
natural join trophies t
natural join users u
natural join 
	(select count(*) as total, l.game_id 
	 from library l 
	 group by l.game_id) sub
where a.game_id = 1
group by a.name, sub.total;

--get products inside bundle_id 13
select pa.bundle_id, pr.product_id, pr.title, pr.type 
from packages pa
inner join products pr on pr.product_id = pa.product_id
inner join bundles b on b.product_id = pa.bundle_id
where pa.bundle_id = 13;

--get game_id 1 with its features, achievements, genres and operetional systems supported
select p.title, g.*, f.name as feature_name, ge.name as genre_name, a.name as achievement_name, r.os
from games g
natural join products p
inner join classifications c on c.game_id = g.game_id
inner join features f on f.feature_id = c.feature_id
inner join categories ca on ca.game_id = g.game_id
inner join genres ge on ge.genre_id = ca.genre_id
inner join achievements a on a.game_id = g.game_id
inner join requirements r on r.game_id = g.game_id
where g.game_id = 1;

--all products visible in catalog for user_id = 1 with is current prince
--with view
select r.region_id, r.currency_symbol, dp.price, dp.net_price,dp.discount, dp.end_date, p.title, p.type
from users u 
natural join regions r
natural join discounted_prices dp
natural join products p
where u.user_id = 1;

--get all medias from every game
select g.game_id, p.product_id, m.url
from medias m
natural join products p
natural join games g
where p.type = 'GAME';

--get all products above 100 dolars from region_id 1
--with view
select dp.region_id, dp.product_id, pr.title as product_title, r.name as region_name, net_price as price
from discounted_prices dp 
natural join products pr
natural join regions r
where dp.net_price > 100
and dp.region_id = 1