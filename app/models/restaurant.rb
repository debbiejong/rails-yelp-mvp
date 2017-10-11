class Restaurant < ApplicationRecord
  has many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
  # validates :category, presence: true
  validates :category, inclusion: { in: ["chinese", "italian", "japanese", "french", "belgian"], allow_nil: false }
end