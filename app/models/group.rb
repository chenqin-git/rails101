class Group < ApplicationRecord #ActiveRecord::Base
  belongs_to :user
  has_many :posts
  validates :title, presence: true

  has_many :
  has_many :members, through: :group_relationships, source: :user
end
