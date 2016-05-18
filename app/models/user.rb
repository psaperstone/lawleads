class User < ActiveRecord::Base
  has_many :purchases
  has_many :properties, through: :purchases
end
