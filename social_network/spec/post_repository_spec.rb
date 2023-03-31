require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "gets all posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 4

    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'My first post'
    expect(posts[0].content).to eq 'wordswordswords'
    expect(posts[0].views).to eq '20'
    expect(posts[0].account_id).to eq '1'
  end

  it "gets a single post by id" do

    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq '1'
    expect(post.title).to eq 'My first post'
    expect(post.content).to eq 'wordswordswords'
    expect(post.views).to eq '20'
    expect(post.account_id).to eq '1'
  end

  it "adds a new post to the database" do
    new_post = Post.new
    new_post.title = 'This is a new post'
    new_post.content = 'newnewnew'
    new_post.views = 12
    new_post.account_id = 1

    repo = PostRepository.new
    repo.create(new_post)

    posts = repo.all
    last_post = posts.last

    expect(last_post.id).to eq '5'
    expect(last_post.title).to eq 'This is a new post'
    expect(last_post.content).to eq 'newnewnew'
    expect(last_post.views).to eq '12'
    expect(last_post.account_id).to eq '1'
  end

  it "updates a post in the database" do
    repo = PostRepository.new
    post = repo.find(1)

    post.title = 'this is not an title'
    repo.update(post)

    updated_post = repo.find(1)

    expect(updated_post.title).to eq 'this is not an title'
    expect(updated_post.content).to eq 'wordswordswords'
  end

  it "deletes a post from the database" do
    repo = PostRepository.new
    repo.delete(1)

    posts = repo.all

    expect(posts.length).to eq 3
    expect(posts.first.id).to eq '2'
    expect(posts.first.title).to eq 'My second post'
    expect(posts.first.content).to eq 'more words'
    expect(posts.first.views).to eq '10'
    expect(posts.first.account_id).to eq '1'
  end
end
