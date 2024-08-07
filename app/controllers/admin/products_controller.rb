module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: [:edit, :update, :destroy]
    def index
      binding.pry
      @products = Product.includes(:category).all
      @products = @products.by_parent_category(params[:parent_category_id]) if params[:parent_category_id].present?
      @products = @products.by_category(params[:category_id]) if params[:category_id].present?
      @products = @products.search(params[:search]) if params[:search].present?
      @products = @products.apply_filter(filters: params[:filters]) if params[:filters].present?
    end

    def new
      @product = Product.new(category_id: params[:category_id] || nil)
    end

    def create
      @product = Product.new(parsed_product_params)
      if @product.save
        images = parsed_product_params[:images]
        if images.present?
          images.each do |image|
            @product.images.attach(image)
          end
        end
        redirect_to admin_products_path, notice: 'Product was successfully created.'
      else
        flash.now[:alert] = @product.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit; end

    def update
      if @product.update(parsed_product_params)
        redirect_to admin_products_path, notice: 'Product was successfully updated.'
      else
        flash.now[:alert] = @product.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path, notice: 'Product was successfully destroyed.'
    end

    private

    def parsed_product_params
      product_params.merge(variants: JSON.parse(product_params[:variants]))
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title,
                                      :description,
                                      :category_id,
                                      :variants,
                                      :price,
                                      images: [])
    end
  end
end
