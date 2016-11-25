class Lesson < ApplicationRecord
  validates_presence_of :subject, :teacher

  belongs_to :kindergarten
  has_many :sutdents
end
