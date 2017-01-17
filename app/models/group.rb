class Group < ApplicationRecord #ActiveRecord::Base
  belongs_to :user
  has_many :posts
  validates :title, presence: true
end
