class Category < ApplicationRecord
  has_many :products
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category', optional: true

  validates :slug, presence: true, uniqueness: true

  scope :parent_categories, -> { where(parent_id: nil) }
end
