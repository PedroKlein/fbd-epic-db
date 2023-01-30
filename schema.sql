--Table and types creation
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    currency_symbol VARCHAR(2) NOT NULL,
    currency_name VARCHAR(20) NOT NULL,
    name VARCHAR(32) NOT NULL
);


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(80) NOT NULL UNIQUE,
    nickname VARCHAR(32) NOT NULL UNIQUE,
    password CHAR(32) NOT NULL,
    region_id INT NOT NULL REFERENCES regions(region_id)
);

CREATE TYPE REFUND_TYPE AS ENUM ('REFUNDABLE', 'SELF_REFUNDABLE', 'NON_REFUNDABLE');
CREATE TYPE PRODUCT_TYPE AS ENUM ('GAME', 'ADDON', 'DEMO', 'EDITION', 'BUNDLE');
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    release_date DATE NOT NULL,
    initial_release_date DATE,
    cover_img VARCHAR(200) NOT NULL,
    refund_type REFUND_TYPE NOT NULL,
    description VARCHAR(2000) NOT NULL,
    title VARCHAR(100) NOT NULL,
    type PRODUCT_TYPE NOT NULL
);

CREATE TYPE MEDIA_TYPE AS ENUM ('IMAGE', 'VIDEO');
CREATE TABLE medias (
    media_order INT check (media_order >= 0),
    product_id INT REFERENCES products(product_id)
                                    ON DELETE CASCADE,
    url VARCHAR(200) NOT NULL,
    media_type MEDIA_TYPE NOT NULL,
    PRIMARY KEY(media_order, product_id)
);

CREATE TYPE DISCOUNT AS (
    percentage NUMERIC(3,2),
    start_date TIMESTAMP WITH TIME ZONE,
    end_date TIMESTAMP WITH TIME ZONE
);
CREATE DOMAIN DISCOUNT_DOMAIN as DISCOUNT 
check (
    value is null or (
  (value).percentage is not null and 
  (value).start_date is not null and
  (value).end_date is not null
  ));
CREATE TABLE prices (
    region_id INT REFERENCES regions(region_id)
                                    ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id)
                                    ON DELETE CASCADE,
    price numeric(7,2) NOT NULL CHECK (price >= 0),
    discount DISCOUNT_DOMAIN,
    PRIMARY KEY(region_id, product_id)
);

CREATE TABLE bundles (
    product_id INT PRIMARY KEY REFERENCES products(product_id)
                                    ON DELETE CASCADE
);

CREATE TABLE packages (
    product_id INT REFERENCES products(product_id)
                        ON DELETE CASCADE,
    bundle_id INT REFERENCES bundles(product_id)
                        ON DELETE CASCADE,
    PRIMARY KEY(product_id, bundle_id)
);

CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id)
                                    ON DELETE CASCADE,
    developer VARCHAR(200) NOT NULL,
    publisher VARCHAR(200) NOT NULL,
    social_newtworks VARCHAR(200)[],
    laucher_name VARCHAR(100),
    languages VARCHAR(50)[] NOT NULL CHECK (array_length(languages, 1) > 0)
);

CREATE TABLE reviews (
    user_id INT REFERENCES users(user_id)
                                ON DELETE CASCADE,
    game_id INT REFERENCES games(game_id) 
                                ON DELETE CASCADE,
    rating SMALLINT NOT NULL CHECK (rating >= 0 AND rating <= 10),
    PRIMARY KEY(user_id, game_id)
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
    genre_id INT REFERENCES genres(genre_id)
                                ON DELETE CASCADE,
    game_id INT REFERENCES games(game_id)
                                ON DELETE CASCADE,
    PRIMARY KEY(genre_id, game_id)
);

CREATE TABLE features (
    feature_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE classifications (
    feature_id INT REFERENCES features(feature_id)
                                ON DELETE CASCADE,
    game_id INT REFERENCES games(game_id)
                                ON DELETE CASCADE,
    PRIMARY KEY(feature_id, game_id)
);

CREATE TYPE ACHIEVEMENT_CATEGORY AS ENUM ('GOLD', 'SILVER', 'BRONZE');
CREATE TABLE achievements (
    name VARCHAR(200),
    game_id INT REFERENCES games(game_id)
                                ON DELETE CASCADE,
    description VARCHAR(200) NOT NULL,
    xp INT NOT NULL CHECK (xp >= 0 AND xp <= 1000),
    category ACHIEVEMENT_CATEGORY NOT NULL,
    PRIMARY KEY(name, game_id)
);

CREATE TYPE ADDON_TYPE AS ENUM ('BOOK', 'GAME_ADDON', 'SOUNDTRACK', 'VIDEO');
CREATE TABLE addons (
    product_id INT PRIMARY KEY REFERENCES products(product_id)
                                    ON DELETE CASCADE,
    addon_type ADDON_TYPE NOT NULL,
    game_id INT NOT NULL REFERENCES games(game_id)
);

CREATE TABLE demos (
    product_id INT PRIMARY KEY REFERENCES products(product_id)
                                    ON DELETE CASCADE,
    duration INTERVAL,
    game_id INT NOT NULL REFERENCES games(game_id)
);


CREATE TABLE editions (
    product_id INT PRIMARY KEY REFERENCES products(product_id)
                                    ON DELETE CASCADE,
    game_id INT NOT NULL REFERENCES games(game_id)
);

CREATE TABLE requirements (
    os VARCHAR(50),
    game_id INT REFERENCES games(game_id)
                                ON DELETE CASCADE,
    minimum JSON NOT NULL,
    recommended JSON NOT NULL,
    PRIMARY KEY(os, game_id)
);

--Inserts
INSERT INTO 
    regions (currency_symbol, currency_name, name)
VALUES
    ('R$','Reais', 'Brazil'),
    ('$','Dollars', 'United States'),
    ('€','Euros', 'Germany');
    
INSERT INTO 
    users (email, nickname, password, region_id)
VALUES
    ('test.user1@ufrgs.br','testUser1', '4229198dbf6ea910ecce0172e14e7a77', 1),
    ('test.user2@ufrgs.br','testUser2', '4229198dbf6ea910ecce0172e14e7a78', 2),
    ('test.user3@ufrgs.br','testUser3', '4229198dbf6ea910ecce0172e14e7a79', 3);
    
INSERT INTO 
    products (release_date, initial_release_date, cover_img, refund_type, description, title, type)
VALUES
    ('2020-10-20',NULL, 'https://image.com/image1.jpg', 'REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Game1', 'GAME'),
    ('2020-10-21','2014-10-21', 'https://image.com/image2.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Game2', 'GAME'),
    ('2020-10-22',NULL, 'https://image.com/image3.jpg', 'REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Game3', 'GAME');

INSERT INTO 
    products (release_date, initial_release_date, cover_img, refund_type, description, title, type)
VALUES
    ('2020-10-20',NULL, 'https://image.com/image1.jpg', 'NON_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Addon1', 'ADDON'),
    ('2020-10-21','2014-10-21', 'https://image.com/image2.jpg', 'NON_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Addon2', 'ADDON'),
    ('2020-10-22',NULL, 'https://image.com/image3.jpg', 'REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Addon3', 'ADDON');

INSERT INTO 
    products (release_date, initial_release_date, cover_img, refund_type, description, title, type)
VALUES
    ('2020-10-20',NULL, 'https://image.com/image1.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Demo1', 'DEMO'),
    ('2020-10-21','2014-10-21', 'https://image.com/image2.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Demo2', 'DEMO'),
    ('2020-10-22',NULL, 'https://image.com/image3.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Demo3', 'DEMO');

INSERT INTO 
    products (release_date, initial_release_date, cover_img, refund_type, description, title, type)
VALUES
    ('2020-10-20',NULL, 'https://image.com/image1.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Edition1', 'EDITION'),
    ('2020-10-21','2014-10-21', 'https://image.com/image2.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Edition2', 'EDITION'),
    ('2020-10-22',NULL, 'https://image.com/image3.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Edition3', 'EDITION');

INSERT INTO 
    products (release_date, initial_release_date, cover_img, refund_type, description, title, type)
VALUES
    ('2020-10-20',NULL, 'https://image.com/image1.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Bundle1', 'BUNDLE'),
    ('2020-10-21','2014-10-21', 'https://image.com/image2.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Bundle2', 'BUNDLE'),
    ('2020-10-22',NULL, 'https://image.com/image3.jpg', 'SELF_REFUNDABLE', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit', 'Bundle3', 'BUNDLE');

INSERT INTO 
    medias (media_order, product_id, url, media_type)
VALUES
    (0, 1, 'https://image.com/image1.jpg', 'IMAGE'),
    (1, 1, 'https://image.com/image2.jpg', 'IMAGE'),
    (2, 1, 'https://image.com/video1.mp4', 'VIDEO');

INSERT INTO 
    prices (region_id, product_id, price, discount)
VALUES
    (1, 1, 25.50, NULL),
    (1, 2, 99.99, ROW(0.80, '2022-10-10', '2022-10-11')),
    (1, 3, 65.20, ROW(0.50, '2022-10-2', '2022-10-8'));
    
INSERT INTO 
    bundles (product_id)
VALUES
    (13),
    (14),
    (15);
    
INSERT INTO 
    packages (product_id, bundle_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3);

INSERT INTO 
    games (product_id, developer, publisher, social_newtworks, laucher_name, languages)
VALUES
    (1, 'developerTest', 'publisherTest', ARRAY ['https://twitter.com/test','https://facebook.com/test'], NULL, ARRAY ['english','portuguese']),
    (2, 'developerTest', 'publisherTest', ARRAY ['https://twitter.com/test'], NULL, ARRAY ['english','portuguese']),
    (3, 'developerTest', 'publisherTest', NULL, 'Test Laucher', ARRAY ['english']);

INSERT INTO 
    reviews (user_id, game_id, rating)
VALUES
    (1, 1, 10),
    (1, 2, 8),
    (1, 3, 1);
    
INSERT INTO 
    categories (genre_id, game_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
    
INSERT INTO 
    features (name)
VALUES
    ('Single Player'),
    ('Multi Player'),
    ('COOP');
    
INSERT INTO 
    classifications (feature_id, game_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
    
INSERT INTO 
    achievements (name, game_id, description, xp, category)
VALUES
    ('AchievementTest1', 1, 'Comple this test', 200, 'SILVER'),
    ('AchievementTest1', 2, 'Comple this test', 400, 'GOLD'),
    ('AchievementTest2', 1, 'Comple this test', 100, 'BRONZE');

INSERT INTO 
    genres (name)
VALUES
    ('Action'),
    ('RPG'),
    ('Sport');
    
INSERT INTO 
    addons (product_id, addon_type, game_id)
VALUES
    (4, 'BOOK', 1),
    (5, 'GAME_ADDON', 1),
    (6, 'SOUNDTRACK', 1);
    
INSERT INTO 
    demos (product_id, duration, game_id)
VALUES
    (7, '40:00:00', 1),
    (8, '35:00:00', 1),
    (9, null, 1);
    
INSERT INTO 
    editions (product_id, game_id)
VALUES
    (10, 1),
    (11, 1),
    (12, 1);
    
INSERT INTO 
    requirements (os, game_id, minimum, recommended)
VALUES
    ('WINDOWS', 1,'{ "testKey": "TestValue"}', '{ "testKey": "TestValue"}' ),
    ('MACOS', 1,'{ "testKey": "TestValue"}', '{ "testKey": "TestValue"}' ),
    ('WINDOWS', 2,'{ "testKey": "TestValue"}', '{ "testKey": "TestValue"}' );