TRUNCATE TABLE accounts, posts RESTART IDENTITY; -- replace with your own table title.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email, username) VALUES ('an_email@gmail.com', 'user_1');
INSERT INTO accounts (email, username) VALUES ('another_email@gmail.com', 'user_2');
