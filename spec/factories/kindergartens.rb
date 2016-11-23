FactoryGirl.define do
  factory :kindergarten do

    # sequence :name do |n|
    #   "school#{n}"
    # end
    name 'school'
    students 1
    open false
  end
end
