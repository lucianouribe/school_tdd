class Sutdent < ApplicationRecord

  validates_presence_of :name
  belongs_to :lesson
end
