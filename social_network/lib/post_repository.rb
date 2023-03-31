require_relative './post'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, title, content, views, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.account_id = record['account_id']

      posts << post
    end

    posts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = 'SELECT id, title, content, views, account_id FROM posts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    result.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.account_id = record['account_id']

      return post
    end
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    sql = 'INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.account_id]

    DatabaseConnection.exec_params(sql, params)
  end

  def update(post)
    sql = 'UPDATE posts SET title = $1, content = $2, views = $3, account_id = $4 WHERE id = $5;'
    params = [post.title, post.content, post.views, post.account_id, post.id]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end
end
