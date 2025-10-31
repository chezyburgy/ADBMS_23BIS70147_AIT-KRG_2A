------------------------------Experiment 08-------------------------------
---------------------Hard Level Problem-----------------------------
/*
Design a robust PostgreSQL transaction system for the students table where multiple student 
records are inserted in a single transaction. 

If any insert fails due to invalid data, only that insert should be rolled back while preserving the 
previous successful inserts using savepoints. 

The system should provide clear messages for both successful and failed insertions, ensuring data integrity 
and controlled error handling.

HINT: YOU HAVE TO USE SAVEPOINTS
*/


SELECT * FROM student;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name = 'student';


SELECT 
    trigger_name,
    event_manipulation AS event,
    action_timing AS timing,
    action_statement AS trigger_function
FROM information_schema.triggers
WHERE event_object_table = 'student';

SELECT * FROM INFORMATION_SCHEMA.TRIGGERS WHERE event_object_table = 'student';

DROP TRIGGER IF EXISTS trg_student ON student;


SELECT * FROM student;


BEGIN TRANSACTION;
DO $$
BEGIN
    INSERT INTO student VALUES
        ('Ishaan', 201, 'AI'),
        ('Tanya', 305, 'ML'),
        ('Karan', 118, 'CSE');

    RAISE NOTICE 'Insertion successful';

EXCEPTION 
    WHEN OTHERS THEN
        RAISE NOTICE 'Unhandled Exception : SQLSTATE % --- %', SQLSTATE, SQLERRM;
        RAISE;
END;
$$;

SELECT * FROM student;

COMMIT;



BEGIN TRANSACTION;
DO $$
BEGIN
    INSERT INTO student VALUES
        ('Ritika', 405, 'DS'),
        ('Aman', 305, 'AI'),    -- Wrong insertion (duplicate ID or invalid)
        ('Neel', 230, 'CSE');

    RAISE NOTICE 'Insertion successful';

EXCEPTION 
    WHEN OTHERS THEN
        RAISE NOTICE 'Unhandled Exception : SQLSTATE % --- %', SQLSTATE, SQLERRM;
        RAISE;
END;
$$;

ROLLBACK;

SELECT * FROM student;

COMMIT;

BEGIN TRANSACTION;

DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT * FROM (VALUES
            ('Ritika', 405, 'DS'),
            ('Aman', 305, 'AI'),    -- Duplicate row, will fail
            ('Neel', 230, 'CSE')
        ) AS t(name, id, dept)
    LOOP
        BEGIN
            SAVEPOINT before_insert;
            INSERT INTO student VALUES (rec.name, rec.id, rec.dept);
            RAISE NOTICE 'Inserted: % (%, %)', rec.name, rec.id, rec.dept;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO SAVEPOINT before_insert;
                RAISE NOTICE 'Error inserting % (%): SQLSTATE % --- %',
                    rec.name, rec.id, SQLSTATE, SQLERRM;
        END;
    END LOOP;

    RAISE NOTICE 'All records processed.';
END;
$$;

COMMIT;

SELECT * FROM student;
