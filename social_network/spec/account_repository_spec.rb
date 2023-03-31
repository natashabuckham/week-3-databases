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

    expect(account.id # =>  '1'
    expect(account.email # =>  'an_email@gmail.com'
    expect(account.username # =>  'user_1'
  end
end
