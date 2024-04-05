SELECT *, answers.text AS answer_text, topics.name AS topic_name
FROM answers
JOIN questions ON answers.question_number = questions.number
JOIN topics ON questions.topic_code = topics.code
ORDER BY topics.display_order ASC, questions.display_order ASC
