DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\ c craigslist;

-- Create regions table
CREATE TABLE regions (
     id SERIAL PRIMARY KEY,
     name TEXT NOT NULL
);

-- Create users table
CREATE TABLE users (
     id SERIAL PRIMARY KEY,
     username TEXT NOT NULL,
     preferred_region_id INTEGER REFERENCES regions(id)
);

-- Create posts table
CREATE TABLE posts (
     id SERIAL PRIMARY KEY,
     title TEXT NOT NULL,
     text TEXT NOT NULL,
     user_id INTEGER REFERENCES users(id),
     location TEXT NOT NULL,
     region_id INTEGER REFERENCES regions(id)
);

-- Create categories table
CREATE TABLE categories (
     id SERIAL PRIMARY KEY,
     name TEXT NOT NULL
);

-- Create posts_categories table for the many-to-many relationship between posts and categories
CREATE TABLE posts_categories (
     post_id INTEGER REFERENCES posts(id),
     category_id INTEGER REFERENCES categories(id),
     PRIMARY KEY (
          post_id,
          category_id
     )
);

-- Insert regions
INSERT INTO
     regions (name)
VALUES
     ('San Francisco'),
     ('Atlanta'),
     ('Seattle');

-- Insert users
INSERT INTO
     users (username, preferred_region_id)
VALUES
     ('user1', 1),
     ('user2', 2),
     ('user3', 3);

-- Insert posts
INSERT INTO
     posts (title, text, user_id, location, region_id)
VALUES
     (
          'Selling iPhone X',
          'Good condition, unlocked iPhone X for sale.',
          1,
          'San Francisco, CA',
          1
     ),
     (
          'Apartment for Rent',
          'Spacious 2-bedroom apartment for rent.',
          2,
          'Atlanta, GA',
          2
     ),
     (
          'Guitar Lessons',
          'Experienced guitar teacher offering lessons.',
          3,
          'Seattle, WA',
          3
     );

-- Insert categories
INSERT INTO
     categories (name)
VALUES
     ('Electronics'),
     ('Housing'),
     ('Services');

-- Insert posts_categories
INSERT INTO
     posts_categories (post_id, category_id)
VALUES
     (1, 1),
     (2, 2),
     (3, 3);

-- Sample queries
-- 1. Retrieve all regions
SELECT
     *
FROM
     regions;

-- 2. Retrieve all users with their preferred region
SELECT
     username,
     name
FROM
     users
     JOIN regions ON preferred_region_id = regions.id;

-- 3. Retrieve all posts with their corresponding user, location, and region
SELECT
     title AS post_title,
     text,
     username,
     location,
     name
FROM
     posts
     JOIN users ON user_id = users.id
     JOIN regions ON region_id = regions.id;

-- 4. Retrieve all categories
SELECT
     *
FROM
     categories;

-- 5. Retrieve all posts along with their categories
SELECT
     title AS post_title,
     name AS category_name
FROM
     posts_categories
     JOIN posts ON post_id = posts.id
     JOIN categories ON category_id = categories.id;

-- 6. Retrieve all posts in a San Francisco
SELECT
     title AS post_title,
     text AS post_description,
     username,
     name AS region_name
FROM
     posts
     JOIN regions ON region_id = regions.id
     JOIN users on user_id = users.id
WHERE
     regions.id = 1;