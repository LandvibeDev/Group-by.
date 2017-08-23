class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :userProfile, UserProfileUploader

  has_many :events
  has_many :userpop3s
  has_many :usermails
  has_many :invites
  has_many :pushs
  has_and_belongs_to_many :groups, -> { distinct }
  has_and_belongs_to_many :projects, -> { distinct }
  has_and_belongs_to_many :team_events, -> { distinct }
end
