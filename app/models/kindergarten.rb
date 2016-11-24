class Kindergarten < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_inclusion_of :open, in: [true, false]

  has_many :lessons
end
