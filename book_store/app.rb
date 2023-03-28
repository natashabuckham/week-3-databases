require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

book_repository = BookRepository.new

instance_array = book_repository.all


instance_array.each do |instance|
  puts "#{instance.id} - #{instance.title} - #{instance.author_name}"
end
