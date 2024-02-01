-- Drop and create tables
DROP TABLE IF EXISTS track;
DROP TABLE IF EXISTS album;

CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE track (
    id SERIAL,
    title VARCHAR(128),
    len INTEGER, rating INTEGER, count INTEGER,
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    UNIQUE(title, album_id),
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track_raw;
CREATE TABLE track_raw
 (title TEXT, artist TEXT, album TEXT, album_id INTEGER,
  count INTEGER, rating INTEGER, len INTEGER);


-- Load the CSV into track_raw using \copy
\COPY track_raw (title,artist,album,count,rating,len) FROM '/home/austinzehnder/library.csv' WITH DELIMITER ',' CSV;

-- Insert all of the distinct albums into the album table
INSERT INTO album (title)
SELECT DISTINCT album
FROM track_raw
ON CONFLICT (title) DO NOTHING;

-- Set the album_id in the track_raw table
UPDATE track_raw SET album_id = (
    SELECT album.id FROM album WHERE album.title = track_raw.album
    );

-- Copy data from track_raw to track
INSERT INTO track (title, len, rating, count, album_id)
SELECT title, len, rating, count, album_id
FROM track_raw;

-- Check result
SELECT track.title, album.title
    FROM track
    JOIN album ON track.album_id = album.id
    ORDER BY track.title LIMIT 3;
