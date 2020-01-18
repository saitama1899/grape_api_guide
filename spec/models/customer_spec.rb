require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:adress) }
end
