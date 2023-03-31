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
    sql = 'SELECT id, email, username FROM accounts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    result.each do |record|
      account = Account.new
      account.id = record['id']
      account.email = record['email']
      account.username = record['username']

      return account
    end
  end

  def create(account)
    sql = 'INSERT INTO accounts (email, username) VALUES ($1, $2);'
    params = [account.email, account.username]

    DatabaseConnection.exec_params(sql, params)
  end

  def update(account)
    sql = 'UPDATE accounts SET email = $1, username = $2 WHERE id = $3;'
    params = [account.email, account.username, account.id]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end
end
