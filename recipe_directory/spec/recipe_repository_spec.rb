require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do
    reset_recipes_table
  end

  it "returns list of recipes" do
    repo = RecipeRepository.new
    recipes = repo.all

    expect(recipes.length).to eq 2
    expect(recipes[0].id).to eq '1'
    expect(recipes[0].title).to eq 'Stir-fry'
    expect(recipes[0].cooking_time).to eq '40'
    expect(recipes[0].rating).to eq'4'
  end

  it "returns a specific recipe when called by id" do
    repo = RecipeRepository.new
    recipe = repo.find(1)

    expect(recipe.id).to eq '1'
    expect(recipe.title).to eq 'Stir-fry'
    expect(recipe.cooking_time).to eq '40'
    expect(recipe.rating).to eq '4'
  end
end
