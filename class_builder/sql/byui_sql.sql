DROP SCHEMA IF EXISTS byui_degrees;
CREATE SCHEMA IF NOT EXISTS byui_degrees;
USE byui_degrees;

-- -----------------------------------------------------
-- Table `courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(10) NOT NULL,
    number VARCHAR(5) NOT NULL,
    title VARCHAR(255) NOT NULL,
    credits INT NOT NULL,
    CONSTRAINT unique_course UNIQUE (subject, number) -- Prevents duplicate courses
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `instructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT unique_instructor UNIQUE (name) -- Prevents duplicate instructors
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS locations;
CREATE TABLE locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    building VARCHAR(50) NOT NULL
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS semesters;
CREATE TABLE semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    term ENUM('Fall', 'Winter', 'Spring', 'Summer') NOT NULL,
    year INT NOT NULL,
    CONSTRAINT unique_semester UNIQUE (term, year) -- Prevents duplicate semester entries
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `course_sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS course_sections;
CREATE TABLE course_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    section VARCHAR(10) NOT NULL,
    schedule VARCHAR(50) NOT NULL,
    instructor_id INT NOT NULL,
    location_id INT NOT NULL,
    semester_id INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE,
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id) ON DELETE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Indexes for Performance
-- -----------------------------------------------------
CREATE INDEX idx_subject ON courses(subject);
CREATE INDEX idx_title ON courses(title);
CREATE INDEX idx_instructor_name ON instructors(name);
CREATE INDEX idx_schedule ON course_sections(schedule);
