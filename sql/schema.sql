--Table and types creation
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    currency_symbol VARCHAR(2) NOT NULL,
    currency_name VARCHAR(20) NOT NULL,
    name VARCHAR(32) NOT NULL UNIQUE
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
    title VARCHAR(100) NOT NULL UNIQUE,
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

CREATE TABLE wishlist (
    user_id INT REFERENCES users(user_id)
                                ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id) 
                                ON DELETE CASCADE,
    PRIMARY KEY(user_id, product_id)
);

CREATE TABLE purchases (
    user_id INT REFERENCES users(user_id)
                                ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id) 
                                ON DELETE CASCADE,
    purchase_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY(user_id, product_id)
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

CREATE TABLE library (
    user_id INT REFERENCES users(user_id)
                                ON DELETE CASCADE,
    game_id INT REFERENCES games(game_id) 
                                ON DELETE CASCADE,
    favourite BOOLEAN DEFAULT false,
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

CREATE TABLE trophies (
    user_id INT REFERENCES users(user_id)
                                ON DELETE CASCADE,
    game_id INT,
    name VARCHAR(200),
    PRIMARY KEY(user_id, game_id, name),
    FOREIGN KEY (game_id, name) REFERENCES achievements(game_id, name)
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