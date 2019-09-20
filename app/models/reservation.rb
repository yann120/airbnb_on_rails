class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :reviews

  validates :start_date, presence: true
  validates :end_date, presence: true

  def host
    self.room.user
  end

  def is_finished
    Time.now > self.end_date
  end
end
