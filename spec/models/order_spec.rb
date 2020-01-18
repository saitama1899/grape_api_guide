require 'rails_helper'

RSpec.describe Order, type: :model do
  # Association test
  # ensure an order record belongs to a single customer record
  it { should belong_to(:customer) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:shipped) }
  it { should validate_presence_of(:delivered) }
end
