-- Active: 1729700947664@@127.0.0.1@5432@university_db



-- Query 1: Insert a new student record with the following details:



INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(7,'MD WAHID',24,'wahidahmed890@gmail.com',50,60,NULL);


-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.



select students.student_name from students WHERE student_id IN (
    select student_id from enrollment  where course_id=(select course_id from courses where course_name='Next.js')
); 

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.



update students  SET status='Awarded' 
WHERE
student_id =(select student_id FROM students
ORDER BY  (frontend_mark + backend_mark) DESC
LIMIT 1);

-- Query 4: Delete all courses that have no students enrolled.

DELETE FROM courses 
 WHERE course_id
  NOT IN (SELECT course_id FROM enrollment);



-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT student_name 
FROM students
ORDER BY student_id LIMIT 2 OFFSET 2;


-- Query 6:Retrieve the course names and the number of students enrolled in each course.

