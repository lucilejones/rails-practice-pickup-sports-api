class Profile < ApplicationRecord
  validates :bio, length: {maximum: 2000}

  belongs_to :user
end
