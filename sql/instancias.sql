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
    ('test.user3@ufrgs.br','testUser3', '4229198dbf6ea910ecce0172e14e7a79', 3),
    ('test.user4@ufrgs.br','testUser4', '4229198dbf6ea910ecce0172e14e7a80', 1),
    ('test.user5@ufrgs.br','testUser5', '4229198dbf6ea910ecce0172e14e7a81', 2);
    
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
    (1, 2, 99.99, ROW(0.80, '2023-03-10', '2023-06-11')),
    (1, 3, 65.20, ROW(0.50, '2023-02-02', '2023-05-08')),
    (2, 1, 50.99, NULL),
    (3, 1, 70.99, NULL),
    (2, 3, 30.20, NULL),
    (1, 4, 9.99, NULL),
    (1, 5, 5.20, NULL),
    (1, 6, 9.99, NULL),
    (1, 7, 0, NULL),
    (1, 8, 0, NULL),
    (1, 9, 0, NULL),
    (1, 10, 109.99, NULL),
    (1, 11, 85.20, NULL),
    (1, 12, 119.99, NULL),
    (1, 13, 165.20, NULL),
    (1, 14, 199.99, NULL),
    (1, 15, 65.20, NULL);

INSERT INTO 
    wishlist (user_id, product_id)
VALUES
    (1, 4),
    (1, 5),
    (1, 6);

INSERT INTO 
    purchases (user_id, product_id, purchase_date)
VALUES
    (1, 1, '2023-01-20'),
    (2, 1, '2023-01-21'),
    (1, 2, '2023-02-05'),
    (1, 3, '2023-03-17'),
    (4, 1, '2023-03-23'),
    (5, 1, '2023-03-21'),
    (3, 3, '2023-03-20');

INSERT INTO 
    bundles (product_id)
VALUES
    (13),
    (14),
    (15);
    
INSERT INTO 
    packages (product_id, bundle_id)
VALUES
    (1, 13),
    (2, 13),
    (3, 13),
    (4, 14),
    (5, 14),
    (1, 15),
    (3, 15);

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
    (2, 1, 4),
    (1, 2, 8),
    (1, 3, 1);

INSERT INTO 
    library (user_id, game_id, favourite)
VALUES
    (1, 1, true),
    (1, 2, false),
    (1, 3, false),
    (2, 1, true),
    (4, 1, true),
    (5, 1, true),
    (3, 3, true);
    
INSERT INTO 
    features (name)
VALUES
    ('Single Player'),
    ('Multi Player'),
    ('COOP');
    
INSERT INTO 
    classifications (feature_id, game_id)
VALUES
    (2, 1),
    (3, 1),
    (1, 2),
    (2, 3);
    
INSERT INTO 
    achievements (name, game_id, description, xp, category)
VALUES
    ('AchievementTest1', 1, 'Comple this test', 200, 'SILVER'),
    ('AchievementTest1', 2, 'Comple this test', 400, 'GOLD'),
    ('AchievementTest2', 1, 'Comple this test', 100, 'BRONZE');

INSERT INTO 
    trophies (name, game_id, user_id)
VALUES
    ('AchievementTest1', 1, 1),
    ('AchievementTest1', 2, 1),
    ('AchievementTest2', 1, 1);

INSERT INTO 
    genres (name)
VALUES
    ('Action'),
    ('RPG'),
    ('Sport');

INSERT INTO 
    categories (genre_id, game_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);
    
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