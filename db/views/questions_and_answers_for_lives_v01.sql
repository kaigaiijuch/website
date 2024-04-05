SELECT *
FROM answers
JOIN questions ON answers.question_number = questions.number
JOIN topics ON questions.topic_code = topics.code
WHERE topic_code = 'life'
ORDER BY display_order
