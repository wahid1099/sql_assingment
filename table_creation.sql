CREATE Table students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age > 0),
    email VARCHAR(50) UNIQUE NOT NULL,
    frontend_mark  INTEGER CHECK (frontend_mark >= 0),
    backend_mark  INTEGER CHECK (backend_mark >= 0),
    status VARCHAR(50)
);


CREATE Table  courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER  CHECK (credits >0)
);



CREATE TABLE enrollment(
   enrollment_id SERIAL PRIMARY KEY,
   student_id INTEGER REFERENCES students(student_id)  ON DELETE CASCADE,
   course_id  INTEGER  REFERENCES courses(course_id) ON DELETE CASCADE
);



INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
(4, 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
(5, 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
(6, 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


INSERT INTO courses (course_id, course_name, credits) VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);


INSERT INTO enrollment (enrollment_id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);