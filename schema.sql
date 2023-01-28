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
    price numeric(5,2),
    discount DISCOUNT
);

CREATE TABLE region (
    region_id SERIAL PRIMARY KEY,
    currency_symbol VARCHAR(2) NOT NULL,
    currency_name VARCHAR(20) NOT NULL,
    name VARCHAR(32) NOT NULL
);

CREATE TYPE REFUND_TYPE AS ENUM ('REFUNDABLE', 'SELF_REFUNDABLE', 'NON_REFUNDABLE');

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    release_date DATE,
    initial_release_date DATE,
    cover_img VARCHAR(200),
    refund_type REFUND_TYPE,
    description VARCHAR(2000),
    title VARCHAR(100)
);

CREATE TYPE MEDIA_TYPE AS ENUM ('IMAGE', 'VIDEO');

CREATE TABLE media (
    order INT PRIMARY KEY,
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    url VARCHAR(200),
    media_type MEDIA_TYPE,
);

CREATE TABLE game (
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    game_id SERIAL PRIMARY KEY,
    developer VARCHAR(200),
    publisher VARCHAR(200),
    social_newtwork VARCHAR(200) ARRAY[]
    laucher_name VARCHAR(100),
    language VARCHAR(50) ARRAY[]
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
    description VARCHAR(200),
    xp INT,
    category ACHIEVEMENT_CATEGORY
);

CREATE TYPE CONTENT_TYPE AS ENUM ('ADDON', 'DEMO', 'EDITION');
CREATE TYPE ADDON_TYPE AS ENUM ('BOOK', 'GAME_ADDON', 'SOUNDTRACK', 'VIDEO');

CREATE TABLE content (
    content_id SERIAL PRIMARY KEY,
    product_id INT PRIMARY KEY REFERENCES product(product_id)
                                    ON DELETE CASCADE,
    content_type CONTENT_TYPE,
    duration INTERVAL,
    addon_type ADDON_TYPE,
    game_id INT NOT NULL REFERENCES game(game_id)
                            ON DELETE CASCADE
);

CREATE TABLE requirement (
    os VARCHAR(50) PRIMARY KEY,
    game_id INT PRIMARY KEY REFERENCES game(game_id)
                                ON DELETE CASCADE,
    minimum JSON,
    recommended JSON
);

--TODO: check
CREATE TABLE bundle (
);

CREATE TABLE package (
    product_id INT REFERENCES product(product_id)
                        ON DELETE CASCADE
);
 
ALTER TABLE Price ADD CONSTRAINT FK_Price_1
    FOREIGN KEY (fk_Region_region_id)
    REFERENCES Region (region_id)
    ON DELETE SET NULL;
 
ALTER TABLE Price ADD CONSTRAINT FK_Price_2
    FOREIGN KEY (fk_Product_product_id)
    REFERENCES Product (product_id)
    ON DELETE SET NULL;
 
ALTER TABLE Category ADD CONSTRAINT FK_Category_1
    FOREIGN KEY (fk_Genre_genre_id)
    REFERENCES Genre (genre_id)
    ON DELETE RESTRICT;
 
ALTER TABLE Category ADD CONSTRAINT FK_Category_2
    FOREIGN KEY (fk_Game_fk_Product_product_id)
    REFERENCES ??? (???);
 
ALTER TABLE Classification ADD CONSTRAINT FK_Classification_1
    FOREIGN KEY (fk_Feature_feature_id)
    REFERENCES Feature (feature_id)
    ON DELETE RESTRICT;
 
ALTER TABLE Classification ADD CONSTRAINT FK_Classification_2
    FOREIGN KEY (fk_Game_fk_Product_product_id)
    REFERENCES ??? (???);
 
ALTER TABLE Review ADD CONSTRAINT FK_Review_1
    FOREIGN KEY (fk_User_user_id, fk_User_email, fk_User_nickname)
    REFERENCES User (user_id, email, nickname)
    ON DELETE SET NULL;
 
ALTER TABLE Review ADD CONSTRAINT FK_Review_2
    FOREIGN KEY (fk_Game_fk_Product_product_id)
    REFERENCES ??? (???);
 
ALTER TABLE Package ADD CONSTRAINT FK_Package_1
    FOREIGN KEY (fk_Product_product_id)
    REFERENCES Product (product_id)
    ON DELETE RESTRICT;