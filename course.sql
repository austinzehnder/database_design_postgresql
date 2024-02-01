-- Insert data into the student table
INSERT INTO student (name) VALUES
    ('Gabby'),
    ('Eamon'),
    ('Jaslyn'),
    ('Manwen'),
    ('Sayad'),
    ('Leiten'),
    ('Aaryn'),
    ('Cieran'),
    ('Derryn'),
    ('Victoria'),
    ('Kassia'),
    ('Aizah'),
    ('Amro'),
    ('Anton'),
    ('India');

-- Insert data into the course table
INSERT INTO course (title) VALUES
    ('si106'),
    ('si110'),
    ('si206');

-- Insert data into the roster table with proper roles
INSERT INTO roster (student_id, course_id, role) VALUES
    (1, 1, 1), -- Gabby, si106, Instructor
    (2, 1, 0), -- Eamon, si106, Learner
    (3, 1, 0), -- Jaslyn, si106, Learner
    (4, 1, 0), -- Manwen, si106, Learner
    (5, 1, 0), -- Sayad, si106, Learner
    (6, 2, 1), -- Leiten, si110, Instructor
    (7, 2, 0), -- Aaryn, si110, Learner
    (8, 2, 0), -- Cieran, si110, Learner
    (9, 2, 0), -- Derryn, si110, Learner
    (10, 2, 0), -- Victoria, si110, Learner
    (11, 3, 1), -- Kassia, si206, Instructor
    (12, 3, 0), -- Aizah, si206, Learner
    (13, 3, 0), -- Amro, si206, Learner
    (14, 3, 0), -- Anton, si206, Learner
    (15, 3, 0); -- India, si206, Learner
