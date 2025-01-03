SELECT
    stud.student_id,
    stud.student_name,
    subj.subject_name,
    COUNT(exam.subject_name) AS attended_exams
FROM
    students as stud
    CROSS JOIN subjects as subj
    LEFT JOIN examinations as exam
        ON stud.student_id = exam.student_id
        AND subj.subject_name = exam.subject_name
GROUP BY
    stud.student_id,
    stud.student_name,
    subj.subject_name
ORDER BY
    stud.student_id ASC,
    subj.subject_name ASC
;