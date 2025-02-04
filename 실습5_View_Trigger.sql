-- View - Trigger

-- Q1. view 생성
-- 1단계 : create table
-- (1) students table 생성
CREATE TABLE students(
	student_id INT PRIMARY KEY,
	NAME VARCHAR(30),
	class VARCHAR(30)
);

-- (2) grades table 생성
CREATE or replace TABLE grades(
	grade_id INT auto_increment PRIMARY KEY,
	student_id INT,
	SUBJECT VARCHAR(30),
	grade CHAR(10),
	FOREIGN KEY(student_id) REFERENCES students(student_id)
	ON DELETE SET NULL ON UPDATE CASCADE
);

-- 추가 : 스키마 수정
-- (1) 참조되고 있는 부분의 foreign key 삭제
SHOW CREATE TABLE grades; -- 외래키 이름 확인
ALTER TABLE grades DROP FOREIGN KEY grades_ibfk_1; 

-- (2) 참조하는 부분의 primary key 삭제
ALTER TABLE students DROP PRIMARY KEY;

-- (3) primary key 재설정
ALTER TABLE students MODIFY student_id INT AUTO_INCREMENT PRIMARY KEY;

-- (4) foreign key 다시 추가
ALTER TABLE grades ADD CONSTRAINT grades_fk_student
FOREIGN KEY (student_id) REFERENCES students(student_id)
ON DELETE SET NULL ON UPDATE CASCADE;

-- 2단계 : 데이터 insert
INSERT
  INTO students
VALUES
(NULL, '유관순','A'),
(NULL, '신사임당','B'),
(NULL, '홍길동','A');

INSERT
  INTO grades
VALUES
(NULL, 1, '과학','A'),
(NULL, 2, '과학','B'),
(NULL, 3, '과학','B'),
(NULL, 1, '수학','B'),
(NULL, 2, '수학','C'),
(NULL, 3, '수학','A');

-- 3단계 : create view
CREATE VIEW student_grades AS
SELECT b.subject, a.name, a.class, b.grade
FROM students a
JOIN grades b ON a.student_id = b.student_id;

-- 4단계 : select
SELECT * FROM student_grades;






