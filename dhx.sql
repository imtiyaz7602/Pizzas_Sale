CREATE DATABASE IF NOT EXISTS stu;
USE stu;

CREATE TABLE student(
      student_id INT PRIMARY KEY,
      Name VARCHAR(40)
);

INSERT INTO student
(student_id, Name)
VALUES
(101, "Adam"),
(102, "Bob"),
(103, "Casey");
CREATE TABLE Course(
    student_id INT PRIMARY KEY,
    Course VARCHAR(50)
);

INSERT INTO Course
(student_id, Course)
VALUES
(102, "English"),
(105, "Math"),
(103, "Science"),
(107, "Computer Science");
-- JOIN lekho ya iiner join same he hai
SELECT * FROM student AS S
INNER JOIN Course AS C
ON S.student_id = C.student_id;

SELECT *FROM student AS S
LEFT JOIN Course AS C
ON S.student_id =C.student_id
WHERE C.student_id IS NULL;

SELECT *FROM student AS S
RIGHT JOIN Course AS C
ON S.student_id =C.student_id
WHERE S.student_id is NULL;

SELECT *FROM student AS S
LEFT JOIN Course AS C
ON S.student_id =C.student_id
UNION 
SELECT *FROM student AS S
RIGHT JOIN Course AS C
ON S.student_id =C.student_id;

SELECT *FROM student AS S
LEFT JOIN Course AS C
ON S.student_id =C.student_id
WHERE C.student_id IS NULL
UNION
SELECT *FROM student AS S
RIGHT JOIN Course AS C
ON S.student_id =C.student_id
WHERE S.student_id is NULL;