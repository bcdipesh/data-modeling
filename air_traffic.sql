-- from the terminal run:
-- psql < air_traffic.sql
DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\ c air_traffic;

-- Create the passengers table
CREATE TABLE passengers (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

-- Create the flights table
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline TEXT NOT NULL,
  from_city TEXT NOT NULL,
  from_country TEXT NOT NULL,
  to_city TEXT NOT NULL,
  to_country TEXT NOT NULL
);

-- Create the seats table
CREATE TABLE seats (
  id SERIAL PRIMARY KEY,
  seat_number TEXT NOT NULL
);

-- Create the tickets table
CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  passenger_id INT REFERENCES passengers(id),
  flight_id INT REFERENCES flights(id),
  seat_id INT REFERENCES seats(id)
);

-- Insert data into the passengers table
INSERT INTO
  passengers (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Waneta', 'Skeleton'),
  ('Alvin', 'Leathes'),
  ('Berkie', 'Wycliff'),
  ('Cory', 'Squibbes');

-- Insert data into the flights table
INSERT INTO
  flights (
    departure,
    arrival,
    airline,
    from_city,
    from_country,
    to_city,
    to_country
  )
VALUES
  (
    '2018-04-08 09:00:00',
    '2018-04-08 12:00:00',
    'United',
    'Washington DC',
    'United States',
    'Seattle',
    'United States'
  ),
  (
    '2018-12-19 12:45:00',
    '2018-12-19 16:15:00',
    'British Airways',
    'Tokyo',
    'Japan',
    'London',
    'United Kingdom'
  ),
  (
    '2018-01-02 07:00:00',
    '2018-01-02 08:03:00',
    'Delta',
    'Los Angeles',
    'United States',
    'Las Vegas',
    'United States'
  ),
  (
    '2018-04-15 16:50:00',
    '2018-04-15 21:00:00',
    'Delta',
    'Seattle',
    'United States',
    'Mexico City',
    'Mexico'
  ),
  (
    '2018-08-01 18:30:00',
    '2018-08-01 21:50:00',
    'TUI Fly Belgium',
    'Paris',
    'France',
    'Casablanca',
    'Morocco'
  ),
  (
    '2018-10-31 01:15:00',
    '2018-10-31 12:55:00',
    'Air China',
    'Dubai',
    'UAE',
    'Beijing',
    'China'
  ),
  (
    '2019-02-06 06:00:00',
    '2019-02-06 07:47:00',
    'United',
    'New York',
    'United States',
    'Charlotte',
    'United States'
  ),
  (
    '2018-12-22 14:42:00',
    '2018-12-22 15:56:00',
    'American Airlines',
    'Cedar Rapids',
    'United States',
    'Chicago',
    'United States'
  ),
  (
    '2019-02-06 16:28:00',
    '2019-02-06 19:18:00',
    'American Airlines',
    'Charlotte',
    'United States',
    'New Orleans',
    'United States'
  ),
  (
    '2019-01-20 19:30:00',
    '2019-01-20 22:45:00',
    'Avianca Brasil',
    'Sao Paolo',
    'Brazil',
    'Santiago',
    'Chile'
  );

-- Insert data into the seats table
INSERT INTO
  seats (seat_number)
VALUES
  ('33B'),
  ('8A'),
  ('12F'),
  ('20A'),
  ('23D'),
  ('18C'),
  ('9E'),
  ('1A'),
  ('32B'),
  ('10D');

-- Insert data into the tickets table
INSERT INTO
  tickets (passenger_id, flight_id, seat_id)
VALUES
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 3),
  (1, 4, 4),
  (4, 5, 5),
  (2, 6, 6),
  (6, 7, 7),
  (5, 8, 8),
  (6, 9, 9),
  (7, 10, 10);