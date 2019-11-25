class Article < ApplicationRecord
  # Adding association between User and Articles
  belongs_to :user
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum:10, maximum:300}
  validates :user_id, presence: true
end