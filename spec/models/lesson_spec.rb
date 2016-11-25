require 'rails_helper'

RSpec.describe Lesson, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:teacher) }
  end

  describe 'associations' do
    it { should belong_to :kindergarten }
    it { should have_many :sutdents }
  end

end
