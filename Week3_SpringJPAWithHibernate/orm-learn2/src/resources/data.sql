-- Create the `country` table
CREATE TABLE IF NOT EXISTS country (
    co_code VARCHAR(10) PRIMARY KEY,
    co_name VARCHAR(255)
);

-- Insert sample country data
INSERT INTO country (co_code, co_name) VALUES 
('BV', 'Bouvet Island'),
('DJ', 'Djibouti'),
('GP', 'Guadeloupe'),
('GS', 'South Georgia and the South Sandwich Islands'),
('LU', 'Luxembourg'),
('SS', 'South Sudan'),
('TF', 'French Southern Territories'),
('UM', 'United States Minor Outlying Islands'),
('ZA', 'South Africa'),
('ZM', 'Zambia'),
('ZW', 'Zimbabwe');
