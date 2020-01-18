require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:customer) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:shipped) }
  it { should validate_presence_of(:delivered) }
end
