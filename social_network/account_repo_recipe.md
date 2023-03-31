# Accounts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `accounts`*

```
# EXAMPLE

Table: accounts

Columns:
id | email | username
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_accounts.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email, username) VALUES ('an_email@gmail.com', 'user_1');
INSERT INTO accounts (email, username) VALUES ('another_email@gmail.com', 'user_2');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username, :post_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# account = account.new
# account.name = 'Jo'
# account.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, username FROM accounts;

    # Returns an array of account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, username FROM accounts WHERE id = $1;

    # Returns a single account object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(account)
  # end

  # def update(account)
  # end

  # def delete(account)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  2

accounts[0].id # =>  '1'
accounts[0].email # =>  'an_email@gmail.com'
accounts[0].username # =>  'user_1'

accounts[1].id # =>  '2'
accounts[1].email # =>  'another_email@gmail.com'
accounts[1].username # =>  'user_2'

# 2
# Get a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  '1'
account.email # =>  'an_email@gmail.com'
account.username # =>  'user_1'

# 3
# Add a new account record to database
new_account = Account.new
new_account.email = 'newemail@gmail.com'
new_account.username = 'user_3'

repo = AccountRepository.new
repo.create(new_account)

accounts = repo.all
last_account = accounts.last

last_account.id # => '3'
last_account.email # => 'newemail@gmail.com'
last_account.username # => 'user_3'

# 4
# Update an account in the database
repo = AccountRepository.new
account = repo.find(1)

account.email = 'this is not an email'
repo.update(account)

updated_account = repo.find(1)

updated_account.email # => 'this is not an email'

# 5
# Deletes an account from the database
repo = AccountRepository.new
repo.delete(1)

accounts = repo.all

accounts.length # => 1
accounts.first.id # => '2'
accounts.first.email # => 'another_email@gmail.com'
accounts.first.username # => 'user_2'


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'accounts' })
  connection.exec(seed_sql)
end

describe accountRepository do
  before(:each) do
    reset_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
