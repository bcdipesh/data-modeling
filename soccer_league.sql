DROP DATABASE IF EXISTS soccer_league;


CREATE DATABASE soccer_league;

\c soccer_league;

-- Create teams table

CREATE TABLE teams (id SERIAL PRIMARY KEY,
                                      name TEXT NOT NULL);

-- Create players table

CREATE TABLE players (id SERIAL PRIMARY KEY,
                                        name TEXT NOT NULL,
                                                  team_id INTEGER REFERENCES teams(id));

-- Create referees table

CREATE TABLE referees (id SERIAL PRIMARY KEY,
                                         name TEXT NOT NULL);

-- Create matches table

CREATE TABLE matches (id SERIAL PRIMARY KEY,
                                        home_team_id INTEGER REFERENCES teams(id),
                                                                        away_team_id INTEGER REFERENCES teams(id),
                                                                                                        referee_id INTEGER REFERENCES referees(id),
                                                                                                                                      match_date DATE NOT NULL);

-- Create goals table

CREATE TABLE goals (id SERIAL PRIMARY KEY,
                                      player_id INTEGER REFERENCES players(id),
                                                                   match_id INTEGER REFERENCES matches(id),
                                                                                               score_time TIME NOT NULL);

-- Create seasons table

CREATE TABLE seasons (id SERIAL PRIMARY KEY,
                                        start_date DATE NOT NULL,
                                                        end_date DATE NOT NULL);

-- Create indices for improved performance

CREATE INDEX idx_players_team_id ON players (team_id);


CREATE INDEX idx_goals_player_id ON goals (player_id);


CREATE INDEX idx_goals_match_id ON goals (match_id);


CREATE INDEX idx_matches_home_team_id ON matches (home_team_id);


CREATE INDEX idx_matches_away_team_id ON matches (away_team_id);


CREATE INDEX idx_matches_referee_id ON matches (referee_id);

-- Create sample seed data
-- Insert teams

INSERT INTO teams (name)
VALUES ('Team A'), ('Team B'), ('Team C');

-- Insert players

INSERT INTO players (name, team_id)
VALUES ('Player 1',
        1), ('Player 2',
             1), ('Player 3',
                  2), ('Player 4',
                       2), ('Player 5',
                            3), ('Player 6',
                                 3);

-- Insert referees

INSERT INTO referees (name)
VALUES ('Referee 1'), ('Referee 2'), ('Referee 3');

-- Insert matches

INSERT INTO matches (home_team_id, away_team_id, referee_id, match_date)
VALUES (1,
        2,
        1,
        '2023-05-01'), (3,
                        1,
                        2,
                        '2023-05-05'), (2,
                                        3,
                                        3,
                                        '2023-05-10');

-- Insert goals

INSERT INTO goals (player_id, match_id, score_time)
VALUES (1,
        1,
        '10:35'), (2,
                   1,
                   '15:12'), (4,
                              1,
                              '22:05'), (3,
                                         2,
                                         '05:23'), (1,
                                                    2,
                                                    '19:41'), (6,
                                                               3,
                                                               '07:58');

-- Insert seasons

INSERT INTO seasons (start_date, end_date)
VALUES ('2023-01-01',
        '2023-12-31');

-- Sample queries
-- 1. Retrieve all teams;

SELECT *
FROM teams;

-- 2. Retrieve all players

SELECT *
FROM players;

-- 3. Retrieve all matches

SELECT m.id AS match_id,
       m.match_date,
       t1.name AS home_team_name,
       t2.name AS away_team_name,
       r.name AS referee_name
FROM matches m
JOIN teams t1 ON m.home_team_id = t1.id
JOIN teams t2 ON m.away_team_id = t2.id
JOIN referees r ON m.referee_id = r.id;

-- 4. Retrieve goals scored along with match and referee details in match no 1

SELECT g.match_id,
       m.match_date,
       t1.name AS home_team_name,
       t2.name AS away_team_name,
       r.name AS referee_name,
       p.name AS player_name,
       g.score_time
FROM goals g
JOIN players p ON g.player_id = p.id
JOIN matches m ON g.match_id = m.id
JOIN teams t1 ON m.home_team_id = t1.id
JOIN teams t2 ON m.away_team_id = t2.id
JOIN referees r ON m.referee_id = r.id
WHERE g.match_id = 1;

-- 5. Retrieve standings/rankings of teams

SELECT t.name AS team_name,
       s.*
FROM teams t
JOIN standings s ON t.id = s.team_id
ORDER BY s.points DESC;

