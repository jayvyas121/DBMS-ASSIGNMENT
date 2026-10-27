

1. Create a simple countries table
CREATE TABLE countries (
    country_id INT,
    country_name VARCHAR(40),
    region_id INT
);
2. Create countries table if it does not already exist
CREATE TABLE IF NOT EXISTS countries (
    country_id INT,
    country_name VARCHAR(40),
    region_id INT
);
3. Create structure of dup_countries similar to countries

This creates only the structure, not the data.

CREATE TABLE dup_countries
LIKE countries;
4. Create duplicate copy of countries including structure and data
CREATE TABLE dup_countries
AS
SELECT *
FROM countries;

Remember:

CREATE TABLE ... LIKE → structure only.
CREATE TABLE ... AS SELECT → structure + data.
5. Create countries table with NULL constraint
CREATE TABLE countries (
    country_id INT NULL,
    country_name VARCHAR(40) NULL,
    region_id INT NULL
);
6. Create jobs table with CHECK on max_salary

The question requires that max_salary should not exceed 25000.

CREATE TABLE jobs (
    job_id VARCHAR(10),
    job_title VARCHAR(35),
    min_salary DECIMAL(6,0),
    max_salary DECIMAL(6,0),
    CHECK (max_salary <= 25000)
);
7. Allow only Italy, India and China
CREATE TABLE countries (
    country_id INT,
    country_name VARCHAR(40),
    region_id INT,
    CHECK (country_name IN ('Italy', 'India', 'China'))
);
8. job_history with date format

The question specifies end_date in the format --/--/----.

In MySQL, the appropriate date data type is DATE.

CREATE TABLE job_history (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT
);

Example date insertion:

INSERT INTO job_history
VALUES (101, '2026-01-01', '2026-08-31', 'IT_PROG', 10);
9. Do not allow duplicate country_id

Use the UNIQUE constraint.

CREATE TABLE countries (
    country_id INT UNIQUE,
    country_name VARCHAR(40),
    region_id INT
);
10. Default values for jobs

Required defaults:

job_title → blank
min_salary → 8000
max_salary → NULL
CREATE TABLE jobs (
    job_id VARCHAR(10),
    job_title VARCHAR(35) DEFAULT ' ',
    min_salary DECIMAL(6,0) DEFAULT 8000,
    max_salary DECIMAL(6,0) DEFAULT NULL
);

This matches the default-value structure shown in your source.

11. Make country_id a key field

Use PRIMARY KEY.

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT
);

A primary key automatically prevents duplicate values.

12. Unique + auto-incremented country_id
CREATE TABLE countries (
    country_id INT UNIQUE AUTO_INCREMENT,
    country_name VARCHAR(40),
    region_id INT
);

If you want the most standard MySQL form, you can make it the primary key as well:

CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT
);
13. Combination of country_id and region_id must be unique

Use a composite UNIQUE constraint.

CREATE TABLE countries (
    country_id INT,
    country_name VARCHAR(40),
    region_id INT,
    UNIQUE (country_id, region_id)
);

This allows the individual values to repeat, but the same combination cannot repeat.

14. job_history with unique employee and foreign key

The question requires:

employee_id must not contain duplicates.
job_id must exist in the jobs table.
CREATE TABLE job_history (
    employee_id INT UNIQUE,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
);
15. employees with composite foreign key

The question requires:

employee_id → no duplicates.
Combination of department_id and manager_id must reference the corresponding combination in departments.
CREATE TABLE employees (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(8,2),
    commission DECIMAL(4,2),
    manager_id DECIMAL(6,0),
    department_id DECIMAL(4,0),

    FOREIGN KEY (department_id, manager_id)
        REFERENCES departments(department_id, manager_id)
);
Important

For this composite foreign key to work, departments must have a matching key/unique constraint on:

(department_id, manager_id)

The source shows those columns as key fields in its stated structure.

16. Employees with two foreign keys

Here:

department_id → references departments(department_id)
job_id → references jobs(job_id)
employee_id → unique.
CREATE TABLE employees (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(8,2),
    commission DECIMAL(4,2),
    manager_id DECIMAL(6,0),
    department_id DECIMAL(4,0),

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
) ENGINE=InnoDB;
17. ON UPDATE CASCADE and ON DELETE RESTRICT

The question specifically asks for:

ON UPDATE CASCADE
ON DELETE RESTRICT
CREATE TABLE employees (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT,
    salary DECIMAL(8,2),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;
Meaning
ON UPDATE CASCADE

If job_id changes in jobs, the corresponding value in employees is automatically updated.

ON DELETE RESTRICT

A job cannot be deleted from jobs if employees are still referring to it.

18. ON DELETE CASCADE and ON UPDATE RESTRICT

The question requires:

ON DELETE CASCADE
ON UPDATE RESTRICT
CREATE TABLE employees (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT,
    salary DECIMAL(8,2),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
) ENGINE=InnoDB;
Meaning
ON DELETE CASCADE

If a job is deleted from the parent jobs table, all employees having that job_id are automatically deleted.

ON UPDATE RESTRICT

Prevents updating the referenced job_id when child records depend on it.

19. ON DELETE SET NULL and ON UPDATE SET NULL

The question requires the child job_id to accept NULL.

CREATE TABLE employees (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT NULL,
    salary DECIMAL(8,2),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE SET NULL
        ON UPDATE SET NULL
) ENGINE=InnoDB;
Meaning

If the corresponding job is deleted:

employees.job_id → NULL

If the referenced job_id is updated:

employees.job_id → NULL
20. ON DELETE NO ACTION and ON UPDATE NO ACTION

The question requires both actions to reject deletion and updates.

CREATE TABLE employees (
    employee_id INT UNIQUE,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    job_id INT,
    salary DECIMAL(8,2),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE=InnoDB;
