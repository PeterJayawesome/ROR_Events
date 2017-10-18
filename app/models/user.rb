class User < ActiveRecord::Base
  belongs_to :state
  has_many :events
  has_many :joins
  has_many :join_events,through: :joins,source: :event
  has_many :comments
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  NAME_REGEX = /\A([A-Za-z_]+)\z/i
  validates :first_name,:last_name,:location, presence:true, length:{minimum:2}
  validates :email, presence:true, uniqueness:true, format:{with:EMAIL_REGEX}
  validates :state, presence:true
  validates :password, presence:true, length:{minimum:8},on: :create
  has_secure_password
end
