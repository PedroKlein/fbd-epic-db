
--TODO: review auto-generated tables
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    name CHARACTER
);

CREATE TABLE Feature (
    feature_id INT PRIMARY KEY,
    name CHARACTER
);

CREATE TABLE User (
    user_id INT,
    email CHARACTER,
    nickname CHARACTER,
    password CHARACTER,
    fk_Region_region_id INT,
    PRIMARY KEY (user_id, email, nickname)
);

CREATE TABLE Region (
    region_id INT PRIMARY KEY,
    currency_symbol CHARACTER,
    currency_name CHARACTER,
    name CHARACTER
);

CREATE TABLE Product (
    release_date DATE,
    initial_release_date DATE,
    cover_img CHARACTER,
    product_id INT PRIMARY KEY,
    refund_type CHARACTER,
    description CHARACTER,
    title CHARACTER
);

CREATE TABLE Media (
    order INT PRIMARY KEY,
    url CHARACTER,
    type CHARACTER,
    fk_Product_product_id INT
);

CREATE TABLE Achievement (
    name CHARACTER PRIMARY KEY,
    description CHARACTER,
    xp INT,
    category CHARACTER,
    fk_Game_fk_Product_product_id INT
);

CREATE TABLE Content (
    fk_Product_product_id INT PRIMARY KEY,
    type CHARACTER,
    duration DATE,
    Content_TIPO INT,
    fk_Game_fk_Product_product_id INT
);

CREATE TABLE Specification_Game (
    specification_id INT,
    fk_language_language_PK INT,
    laucher_name CHARACTER,
    publisher CHARACTER,
    fk_social_networks_social_networks_PK INT,
    developer CHARACTER,
    fk_Product_product_id INT,
    PRIMARY KEY (specification_id, fk_Product_product_id)
);

CREATE TABLE Requirement (
    os CHARACTER PRIMARY KEY,
    min_requirement CHARACTER,
    recommended_req CHARACTER,
    fk_Specification_Game_specification_id INT
);

CREATE TABLE Bundle (
);

CREATE TABLE social_networks (
    social_networks_PK INT NOT NULL PRIMARY KEY,
    social_networks CHARACTER
);

CREATE TABLE language (
    language_PK INT NOT NULL PRIMARY KEY,
    language CHARACTER
);

CREATE TABLE Price (
    fk_Region_region_id INT,
    fk_Product_product_id INT,
    price FLOAT,
    percentage FLOAT,
    start_date DATE,
    end_date DATE
);

CREATE TABLE Category (
    fk_Genre_genre_id INT,
    fk_Game_fk_Product_product_id INT
);

CREATE TABLE Classification (
    fk_Feature_feature_id INT,
    fk_Game_fk_Product_product_id INT
);

CREATE TABLE Review (
    fk_User_user_id INT,
    fk_User_email CHARACTER,
    fk_User_nickname CHARACTER,
    fk_Game_fk_Product_product_id INT,
    rating INT
);

CREATE TABLE Package (
    fk_Product_product_id INT
);
 
ALTER TABLE User ADD CONSTRAINT FK_User_2
    FOREIGN KEY (fk_Region_region_id)
    REFERENCES Region (region_id)
    ON DELETE CASCADE;
 
ALTER TABLE Media ADD CONSTRAINT FK_Media_2
    FOREIGN KEY (fk_Product_product_id)
    REFERENCES Product (product_id)
    ON DELETE RESTRICT;
 
ALTER TABLE Achievement ADD CONSTRAINT FK_Achievement_2
    FOREIGN KEY (fk_Game_fk_Product_product_id)
    REFERENCES ??? (???);
 
ALTER TABLE Content ADD CONSTRAINT FK_Content_2
    FOREIGN KEY (fk_Product_product_id)
    REFERENCES Product (product_id)
    ON DELETE CASCADE;
 
ALTER TABLE Content ADD CONSTRAINT FK_Content_3
    FOREIGN KEY (fk_Game_fk_Product_product_id)
    REFERENCES ??? (???);
 
ALTER TABLE Specification_Game ADD CONSTRAINT FK_Specification_Game_2
    FOREIGN KEY (fk_language_language_PK)
    REFERENCES language (language_PK)
    ON DELETE NO ACTION;
 
ALTER TABLE Specification_Game ADD CONSTRAINT FK_Specification_Game_3
    FOREIGN KEY (fk_social_networks_social_networks_PK)
    REFERENCES social_networks (social_networks_PK);
 
ALTER TABLE Specification_Game ADD CONSTRAINT FK_Specification_Game_4
    FOREIGN KEY (fk_Product_product_id)
    REFERENCES Product (product_id);
 
ALTER TABLE Requirement ADD CONSTRAINT FK_Requirement_2
    FOREIGN KEY (fk_Specification_Game_specification_id, ???)
    REFERENCES Specification_Game (specification_id, ???)
    ON DELETE RESTRICT;
 
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