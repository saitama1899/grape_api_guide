class Order < ApplicationRecord
  belongs_to :customer
  validates_presence_of :name
  validates_presence_of :shipped
  validates_presence_of :delivered
end
