class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates_presence_of :name, :adress
end
