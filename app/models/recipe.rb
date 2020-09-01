class Recipe < ApplicationRecord
  validates: :title, :ingredients, :link, presence: true
  belongs_to :search
end
