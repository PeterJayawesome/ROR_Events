class Event < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  has_many :comments,dependent: :destroy
  has_many :joins,dependent: :destroy
  has_many :users,through: :joins, source: :user
  validates :name,:location, presence:true, length:{minimum:2}
  validates_date :date, :after => lambda { Date.current }
  validates :state, presence:true
  validates :user, presence:true
end
