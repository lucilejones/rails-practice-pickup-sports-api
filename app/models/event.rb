class Event < ApplicationRecord
include Rails.application.routes.url_helpers

  # active storage
  has_one_attached :cover_image

  # validations
  validates :start_date_time, :end_date_time, :guests, presence: true
  validates :title, presence: true

  validate :start_date_time_cannot_be_in_past,
  :end_date_time_cannot_be_before_start_date_time

  # associations
  # belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  has_one :location, as: :locationable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :event_participants
  # has_many :users, through: :event_participants
  has_many :participants, through: :event_participants, source: :user

  has_and_belongs_to_many :sports

  def start_date_time_cannot_be_in_past
    if start_date_time.present? && start_date_time < DateTime.now
        errors.add(:start_date_time, "can't be in the past")
    end
  end

  def end_date_time_cannot_be_before_start_date_time
    if end_date_time < start_date_time
        errors.add(:end_date_time, "can't be before start_date_time")
    end
  end

  def cover_image_url
    rails_blob_url(self.cover_image, only_path: false) if self.cover_image.attached?
  end

  def has_joined?(user)
    self.participants.include?(user);
  end
end
