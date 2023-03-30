TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table title.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, account_id) VALUES ('My first post', 'wordswordswords', 20, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('My second post', 'more words', 10, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('Blogs are fun', 'here is why', 15, 2);
INSERT INTO posts (title, content, views, account_id) VALUES ('I hate blogs now', 'this is what happened', 1000, 2);
