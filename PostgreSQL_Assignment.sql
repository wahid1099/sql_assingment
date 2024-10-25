-- Active: 1729700947664@@127.0.0.1@5432@university_db

-- Table creation for "students" with constraints
CREATE Table students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age > 0),
    email VARCHAR(50) UNIQUE NOT NULL,
    frontend_mark  INTEGER CHECK (frontend_mark >= 0),
    backend_mark  INTEGER CHECK (backend_mark >= 0),
    status VARCHAR(50)
);

-- Table creation for "courses" with constraints

CREATE Table  courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER  CHECK (credits >0)
);


-- Table creation for "enrollment" with foreign key constraints
CREATE TABLE enrollment(
   enrollment_id SERIAL PRIMARY KEY,
   student_id INTEGER REFERENCES students(student_id)  ON DELETE CASCADE,
   course_id  INTEGER  REFERENCES courses(course_id) ON DELETE CASCADE
);

-- Insert sample data into "students" table

INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
(4, 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
(5, 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
(6, 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- Insert sample data into "courses" table
INSERT INTO courses (course_id, course_name, credits) VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);

-- Insert sample data into "enrollment" table

INSERT INTO enrollment (enrollment_id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

-- Query 1: Insert a new student record with the following details:

--ans : we are inserting data into the table 

INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(7,'MD WAHID',24,'wahidahmed890@gmail.com',50,60,NULL);


-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.

-- ans : we are using nested query first we will retrive course id then we will match the students with that course id and find all student names by id we get from nested query 

select students.student_name from students WHERE student_id IN (
    select student_id from enrollment  where course_id=(select course_id from courses where course_name='Next.js')
); 

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
-- ans :we are ordering the table and limiting it to so we get the highest mark from descending order and the we find the student and update his data


update students  SET status='Awarded' 
WHERE
student_id =(select student_id FROM students
ORDER BY  (frontend_mark + backend_mark) DESC
LIMIT 1);

-- Query 4: Delete all courses that have no students enrolled.
-- ans :Deleting the course which does not match in enrollment table as they are not enrolled so they will be not available in that table

DELETE FROM courses 
 WHERE course_id
  NOT IN (SELECT course_id FROM enrollment);



-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
--ans : we are retriving student the offset will skip first two names and limit will give us the two name
SELECT student_name 
FROM students
ORDER BY student_id LIMIT 2 OFFSET 2;


-- Query 6:Retrieve the course names and the number of students enrolled in each course.
-- ans :we use a JOIN between the courses and enrollment tables and then group the results by course_id 
SELECT c.course_name ,COUNT(e.student_id) as student_count
FROM courses c
LEFT JOIN enrollment e ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name;


-- Query 7:
-- Calculate and display the average age of all students.
-- ans :getting the average with aggregiate function 

SELECT AVG(age) as average_age FROM students;


-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
-- ans :finding the email that matches or have ''example.com'.'

SELECT student_name FROM students WHERE email LIKE '%example.com%';