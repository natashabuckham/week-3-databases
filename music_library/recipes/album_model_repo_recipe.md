# Album Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `albums`*

```
# EXAMPLE

Table: albums

Columns:
id | title | release_year | artist_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_albums.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES('Doolittle', 1989, 1);
INSERT INTO albums (title, release_year, artist_id) VALUES('Surfer Rosa', 1988, 1);
INSERT INTO albums (title, release_year, artist_id) VALUES('Waterloo', 1974, 2);
INSERT INTO albums (title, release_year, artist_id) VALUES('Super Trooper', 1980, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql # make sure the .sql file specifies the path if you are not running from within the spec folder. Would need to be spec/seeds_etc.
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Album

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year FROM albums;

    # Returns an array of Album objects.
  end

  def create(album)
    # Executes the SQL query:
    # INSERT INTO albums (title, release_year) VALUES ($1, $2);
    # returns nothing, just creates the record in the database
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM albums WHERE id = $1;
    # returns nothing, only deletes the record from the database
  end

  def update(album)
    # Updates an album record
    # Takes an Album object (with the updated fields)
    # Executes the SQL query:
    # UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;
    # returns nothing, just updates the record in the database
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all
albums.length # => 4
albums.first.id # => '1'
albums.first.title # => 'Doolittle'
albums.first.release_year # => '1989'
albums.first.artist_id # => '1'

# 2
# Create a new album
repo = AlbumRepository.new

album = Album.new
album.title = 'The Good Life'
album.release_year = 2018
album.artist_id = 3

repo.create(album) # => nil
albums = repo.all
last_album = album.last

last_album.title # => 'The Good Life'
last_album.release_year # => '2018'
last_album.artist_id # => '3'

# 3
# Delete an album
repo = AlbumRepository.new
id_to_delete = 1
repo.delete(id_to_delete)

all_albums = repo.all
all_albums.length # => 3
all_albums.first.id # => '2'

# 4
# Update an album
repo = AlbumRepository.new
album = repo.find(1) # get the object we want to update

album.title = 'Something else'
album.release_year = 3000

repo.update(album)
updated_album = repo.find(1)

updated_album.title # => 'Something else'
updated_album.release_year # => '3000'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
