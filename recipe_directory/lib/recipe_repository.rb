require_relative './recipe'

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, title, cooking_time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    result_set.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.title = record['title']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']

      recipes << recipe
    end

    recipes
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = 'SELECT id, title, cooking_time, rating FROM recipes WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    selected_recipe = nil

    result.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.title = record['title']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']

      selected_recipe = recipe
    end
    selected_recipe
  end
end
