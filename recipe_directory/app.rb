require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

instance_array = recipe_repository.all

instance_array.each do |instance|
  puts "#{instance.id} - #{instance.title}: #{instance.cooking_time} minutes, #{instance.rating} stars"
end

