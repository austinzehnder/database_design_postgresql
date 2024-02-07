-- Drop then create the bigtext table
DROP TABLE IF EXISTS bigtext;

CREATE TABLE bigtext (
    content TEXT NOT NULL
);

-- Insert generated data into bigtext
INSERT INTO bigtext (content)
SELECT CONCAT('This is record number ', generate_series(100000, 199999), ' of quite a few text records.')
FROM generate_series(1, 1);
