CREATE TABLE IF NOT EXISTS department (
    dp_id INT PRIMARY KEY AUTO_INCREMENT,
    dp_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS employee (
    em_id INT PRIMARY KEY AUTO_INCREMENT,
    em_name VARCHAR(255),
    em_salary DOUBLE,
    em_permanent BOOLEAN,
    em_date_of_birth DATE,
    em_dp_id INT,
    FOREIGN KEY (em_dp_id) REFERENCES department(dp_id)
);

CREATE TABLE IF NOT EXISTS skill (
    sk_id INT PRIMARY KEY AUTO_INCREMENT,
    sk_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS employee_skill (
    es_em_id INT,
    es_sk_id INT,
    PRIMARY KEY (es_em_id, es_sk_id),
    FOREIGN KEY (es_em_id) REFERENCES employee(em_id),
    FOREIGN KEY (es_sk_id) REFERENCES skill(sk_id)
);
