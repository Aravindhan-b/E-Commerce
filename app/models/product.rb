class Product < ApplicationRecord
  include Searchable
  attr_accessor :filtered_products

  belongs_to :category
  validates :title, :description, :variants, presence: true
  has_many_attached :images

  COLORS = %w[red green blue yellow black white brown].freeze
  SIZE = %w[s m l xl xxl xxxl].freeze
  PRICE = %w[0-1000 1001-10000 10001-20000 20001-30000 30001-100000].freeze
  FILTERS = %w[price color size].freeze

  scope :by_category, ->(category_id) { where(category_id:) }

  def resize_image(image)
    image.variant(resize: '100x100').processed
  end

  def self.descendent_category_ids(category)
    subcategory_ids = category.subcategories.pluck(:id)
    category.subcategories.map do |sub_category|
      subcategory_ids << descendent_category_ids(sub_category)
    end
    subcategory_ids
  end

  def self.by_parent_category(parent_category_id)
    binding.pry
    category = Category.find(parent_category_id)
    descendent_ids = descendent_category_ids(category) + [category.id]
    where(category_id: descendent_ids.flatten)
  end

  def self.apply_filter(filters:)
    filtered_products = Product.all
    if filters['price']
      price_range = filters['price']
      filtered_products = price_range.map do |range|
        min, max = range.split('-').map(&:strip).map(&:to_i).sort
        where(price: min..max)
      end.flatten
    end

    if filters['color'].present? && filters['size'].present?
      color = filters['color']
      size = filters['size']
      filtered_products = filtered_products&.select do |product|
        product.variants.any? { |variant| color.include?(variant['color']) && size.include?(variant['size']) }
      end
    else
      if filters['color'].present?
        color = filters['color']
        filtered_products = filtered_products&.select do |product|
          product.variants.any? { |variant| color.include?(variant['color']) }
        end
      end

      if filters['size'].present?
        size = filters['size']
        filtered_products = filtered_products&.select do |product|
          product.variants.any? { |variant| size.include?(variant['size']) }
        end
      end
    end
    filtered_products
  end
end
