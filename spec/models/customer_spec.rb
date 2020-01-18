require 'rails_helper'

RSpec.describe Customer, type: :model do
  # Association test
  # ensure Customer model has a 1:m relationship with the Order model and delets on cascade
  it { should have_many(:orders).dependent(:destroy) }
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:adress) }
end
