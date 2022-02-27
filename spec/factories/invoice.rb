FactoryBot.define do
  factory :invoice, class: Invoice do
    status { (["completed", "cancelled", "in progress"]).sample(1)[0] }
    customer
  end
end
