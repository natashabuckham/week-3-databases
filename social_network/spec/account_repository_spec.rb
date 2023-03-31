require 'account_repository'

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe AccountRepository do
  before(:each) do
    reset_accounts_table
  end

  it "gets all accounts" do
    repo = AccountRepository.new

    accounts = repo.all

    expect(accounts.length).to eq 2

    expect(accounts[0].id).to eq '1'
    expect(accounts[0].email).to eq 'an_email@gmail.com'
    expect(accounts[0].username).to eq 'user_1'

    expect(accounts[1].id).to eq '2'
    expect(accounts[1].email).to eq 'another_email@gmail.com'
    expect(accounts[1].username).to eq 'user_2'
  end

  it "gets a single account by id" do
    repo = AccountRepository.new

    account = repo.find(1)

    expect(account.id).to eq '1'
    expect(account.email).to eq 'an_email@gmail.com'
    expect(account.username).to eq 'user_1'
  end

  it "adds a new account record to database" do
    new_account = Account.new
    new_account.email = 'newemail@gmail.com'
    new_account.username = 'user_3'

    repo = AccountRepository.new
    repo.create(new_account)

    accounts = repo.all
    last_account = accounts.last

    expect(last_account.id).to eq '3'
    expect(last_account.email).to eq 'newemail@gmail.com'
    expect(last_account.username).to eq 'user_3'
  end

  it "updates an account in the database" do
    
  end
end
