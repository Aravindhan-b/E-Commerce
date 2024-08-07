module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update, :destroy, :show]
    def index
      @categories = Category.all
    end

    def new
      @category = Category.new(parent_id: params[:parent_id] || nil)
    end

    def create
      @category = Category.new(parse_category_params)
      if @category.save
        if @category.parent_id.present?
          redirect_to admin_category_path(@category.parent_id), notice: 'Category was successfully created.'
        else
          redirect_to parent_categories_admin_categories_path, notice: 'Category was successfully created.'
        end
      else
        flash.now[:alert] = @category.errors.full_messages.to_sentence
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      if @category.update(parse_category_params)
        redirect_to parent_categories_admin_categories, notice: 'Category was successfully updated.'
      else
        flash.now[:alert] = @category.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to parent_categories_admin_categories, notice: 'Category was successfully destroyed.'
    end

    def parent_categories
      @categories = Category.parent_categories
    end

    private

    def parse_category_params
      category_params.merge(size: category_params[:size].split('$'), color: category_params[:color].split('$'))
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:slug, :parent_id, :size, :color)
    end
  end
end
