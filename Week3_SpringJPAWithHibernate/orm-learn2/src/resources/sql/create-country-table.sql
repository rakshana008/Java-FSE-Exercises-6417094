CREATE TABLE IF NOT EXISTS country (
    co_code VARCHAR(10) PRIMARY KEY,
    co_name VARCHAR(255)
);

INSERT INTO country (co_code, co_name) VALUES
('ZA', 'South Africa'),
('LU', 'Luxembourg'),
('DJ', 'Djibouti'),
('TF', 'French Southern Territories'),
('UM', 'United States Minor Outlying Islands'),
('BV', 'Bouvet Island'),
('GP', 'Guadeloupe'),
('SS', 'South Sudan'),
('GS', 'South Georgia and the South Sandwich Islands');
