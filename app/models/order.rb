class Order < ApplicationRecord
  belongs_to :customer
  validates_presence_of :name
  validates_inclusion_of :shipped, :in => [true, false]
  validates_inclusion_of :delivered, :in => [true, false]
end
