FactoryBot.define do
  factory :invoice, class: Invoice do
<<<<<<< HEAD
    status { (["completed", "cancelled", "in progress"]).sample(1)[0] }
=======
    status { (['completed', 'cancelled', 'in progress']).sample(1)[0] } # What should we pass?
>>>>>>> e23c6f47c5743939519913e030fb975813633a5d
    customer
  end
end
