require_relative './account'

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, email, username FROM accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    accounts = []

    result_set.each do |record|
      account = Account.new
      account.id = record['id']
      account.email = record['email']
      account.username = record['username']

      accounts << account
    end

    accounts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email, username FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(account)
    # SQL
    # INSERT INTO accounts (email, username) VALUES ($1, $2)
    # returns nothing, just updates database
  end

  def update(account)
    # SQL:
    # UPDATE accounts SET email = $1, username = $2 WHERE id = $3
    # returns nothing
  end

  def delete(id)
    # SQL:
    # DELETE FROM accounts WHERE id = $1
    # returns nothing
  end
end
