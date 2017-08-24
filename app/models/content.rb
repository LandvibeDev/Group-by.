class Content < ApplicationRecord

  mount_uploader :image, ContentImageUploader

  belongs_to :group
  belongs_to :user
  has_many :selected_users, through: :selecteds, source: :user
  has_many :comments
end
