CREATE TABLE user (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(80) NOT NULL UNIQUE,
    nickname VARCHAR(32) NOT NULL UNIQUE,
    password CHAR(32) NOT NULL,
    region_id INT NOT NULL REFERENCES region(region_id)
);

CREATE TABLE review (
    user_id INT PRIMARY KEY REFERENCES user(user_id)
                                ON DELETE CASCADE,
    game_id INT PRIMARY KEY REFERENCES game(game_id) 
                                ON DELETE CASCADE,
    rating SMALLINT NOT NULL CHECK (rating >= 0 AND rating <= 10)
);

CREATE TYPE DISCOUNT AS (
    percentage NUMERIC(1,2) NOT NULL,
    start_date TIMESTAMPZ NOT NULL,
    end_date TIMESTAMPZ NOT NULL
);

CREATE TABLE price (
    region_id INT PRIMARY KEY REFERENCES region(region_id)
                                    ON DELETE CASCADE,
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    price numeric(5,2) NOT NULL CHECK (price >= 0),
    discount DISCOUNT
);

CREATE TABLE region (
    region_id SERIAL PRIMARY KEY,
    currency_symbol VARCHAR(2) NOT NULL,
    currency_name VARCHAR(20) NOT NULL,
    name VARCHAR(32) NOT NULL
);

CREATE TYPE REFUND_TYPE AS ENUM ('REFUNDABLE', 'SELF_REFUNDABLE', 'NON_REFUNDABLE');
CREATE TYPE PRODUCT_TYPE AS ENUM ('GAME', 'ADDON', 'DEMO', 'EDITION', 'BUNDLE');

CREATE TABLE product (
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

CREATE TABLE media (
    order INT PRIMARY KEY check (order >= 0),
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    url VARCHAR(200) NOT NULL,
    media_type MEDIA_TYPE NOT NULL,
);

CREATE TABLE bundle (
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE
);

CREATE TABLE package (
    product_id INT REFERENCES product(product_id)
                        ON DELETE CASCADE,
    bundle_id INT REFERENCES bundle(product_id)
                        ON DELETE CASCADE
);

CREATE TABLE game (
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    game_id SERIAL PRIMARY KEY,
    developer VARCHAR(200) NOT NULL,
    publisher VARCHAR(200) NOT NULL,
    social_newtworks VARCHAR(200) ARRAY[]
    laucher_name VARCHAR(100),
    language VARCHAR(50) ARRAY[] NOT NULL CHECK (array_length(language, int) > 0)
);

CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE category (
    genre_id INT PRIMARY KEY REFERENCES genre(genre_id)
                                ON DELETE CASCADE,
    game_id INT PRIMARY KEY REFERENCES game(game_id)
                                ON DELETE CASCADE
);

CREATE TABLE feature (
    feature_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE classification (
    feature_id INT PRIMARY KEY REFERENCES feature(feature_id)
                                ON DELETE CASCADE,
    game_id INT PRIMARY KEY REFERENCES game(game_id)
                                ON DELETE CASCADE
);

CREATE TYPE ACHIEVEMENT_CATEGORY AS ENUM ('GOLD', 'SILVER', 'BRONZE');

CREATE TABLE achievement (
    name VARCHAR(200) PRIMARY KEY,
    game_id INT PRIMARY KEY REFERENCES game(game_id)
                                ON DELETE CASCADE,
    description VARCHAR(200) NOT NULL,
    xp INT NOT NULL CHECK (xp >= 0 AND xp <= 1000),
    category ACHIEVEMENT_CATEGORY NOT NULL
);

-- CREATE TYPE CONTENT_TYPE AS ENUM ('ADDON', 'DEMO', 'EDITION');

-- CREATE TABLE content (
--     product_id INT PRIMARY KEY REFERENCES product(product_id)
--                                     ON DELETE CASCADE,
--     content_type CONTENT_TYPE NOT NULL,
--     duration INTERVAL,
--     addon_type ADDON_TYPE,
--     game_id INT NOT NULL REFERENCES game(game_id)
-- );

CREATE TYPE ADDON_TYPE AS ENUM ('BOOK', 'GAME_ADDON', 'SOUNDTRACK', 'VIDEO');
CREATE TABLE addon (
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    addon_type ADDON_TYPE NOT NULL,
    game_id INT NOT NULL REFERENCES game(game_id)
);

CREATE TABLE demo (
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    duration INTERVAL,
    game_id INT NOT NULL REFERENCES game(game_id)
);

CREATE TABLE edition (
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    game_id INT NOT NULL REFERENCES game(game_id)
);

CREATE TABLE requirement (
    os VARCHAR(50) PRIMARY KEY,
    game_id INT PRIMARY KEY REFERENCES game(game_id)
                                ON DELETE CASCADE,
    minimum JSON NOT NULL,
    recommended JSON NOT NULL
);