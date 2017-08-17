class Content < ApplicationRecord

  belongs_to :group
  has_many :selected_users, through: :selecteds, source: :user
  has_many :comments

  validate :end_after_start
  validates :start_date, :end_date, :presence => true

  private
  def end_after_start
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
