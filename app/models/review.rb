class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements
  
  validates :rating, inclusion: (1..5)

  def created_by?(user)
    user == self.user
  end
end
