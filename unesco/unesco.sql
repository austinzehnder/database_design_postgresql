-- Table structure setup
DROP TABLE unesco_raw;
CREATE TABLE unesco_raw
 (name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category TEXT, category_id INTEGER, state TEXT, state_id INTEGER,
    region TEXT, region_id INTEGER, iso TEXT, iso_id INTEGER);

DROP TABLE category;
CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

-- Create more tables
DROP TABLE iso;
CREATE TABLE iso (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE state;
CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

DROP TABLE region;
CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

-- Load CSV
\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) FROM '/home/austinzehnder/whc-sites-2018-small.csv' WITH DELIMITER ',' CSV HEADER;

-- Add entries to each of the lookup tables (category, etc.)
INSERT INTO category (name)
SELECT DISTINCT category
FROM unesco_raw
ON CONFLICT (name) DO NOTHING;

INSERT INTO iso (name)
SELECT DISTINCT iso
FROM unesco_raw
ON CONFLICT (name) DO NOTHING;

INSERT INTO state (name)
SELECT DISTINCT state
FROM unesco_raw
ON CONFLICT (name) DO NOTHING;

INSERT INTO region (name)
SELECT DISTINCT region
FROM unesco_raw
ON CONFLICT (name) DO NOTHING;

-- Add foreign key columns to the unesco_raw table
UPDATE unesco_raw SET category_id = (
    SELECT id FROM category WHERE category.name = unesco_raw.category
    );

UPDATE unesco_raw SET iso_id = (
    SELECT id FROM iso WHERE iso.name = unesco_raw.iso
    );

UPDATE unesco_raw SET state_id = (
    SELECT id FROM state WHERE state.name = unesco_raw.state
    );

UPDATE unesco_raw SET region_id = (
    SELECT id FROM region WHERE region.name = unesco_raw.region
    );

-- Create new unesco table that removes all of the un-normalized redundant text columns like category
DROP TABLE unesco;
CREATE TABLE unesco (
    name TEXT, year INTEGER, category_id INTEGER, state_id INTEGER, region_id INTEGER, iso_id INTEGER
    );

INSERT INTO unesco (name, year, category_id, state_id, region_id, iso_id)
SELECT name, year, category_id, state_id, region_id, iso_id
FROM unesco_raw;

-- Check results
SELECT unesco.name, year, category.name, state.name, region.name, iso.name
  FROM unesco
  JOIN category ON unesco.category_id = category.id
  JOIN iso ON unesco.iso_id = iso.id
  JOIN state ON unesco.state_id = state.id
  JOIN region ON unesco.region_id = region.id
  ORDER BY region.name, unesco.name
  LIMIT 3;
