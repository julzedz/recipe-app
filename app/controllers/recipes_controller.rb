class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @recipes = Recipe.all
  end

  def public_recipes
    @recipes = Recipe.where(public: true)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      flash[:notice] = 'Recipe was successfully created.'
      redirect_to recipes_path
    else
      render :new
    end
  end

  def show
    begin
      @recipe = Recipe.find(params[:id])
      @foods = if current_user && current_user.id == @recipe.user_id
                 RecipeFood.where(recipe_id: @recipe.id).includes(:recipe, :food)
               else
                 RecipeFood.where(recipe_id: @recipe.id).includes(:food)
               end
    rescue ActiveRecord::RecordNotFound
      # Handle the case when the recipe with the given id is not found.
      # You can redirect to an error page or render a 404 page.
      redirect_to root_path, alert: 'Recipe not found.'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'Recipe was successfully deleted.'
    redirect_to recipes_path
  end

  # ... (rest of the actions)

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def authorize_user
    return if @recipe.user == current_user

    redirect_to root_path, alert: 'You are not authorized to perform this action.'
  end
end
