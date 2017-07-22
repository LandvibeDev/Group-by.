class Userpop3 < ApplicationRecord

  belongs_to :user
  has_many :usermails
end
