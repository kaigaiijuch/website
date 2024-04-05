SELECT *
FROM answers
JOIN questions ON answers.question_number = questions.number
JOIN topics ON questions.topic_code = topics.code
ORDER BY topics.display_order ASC, questions.display_order ASC
