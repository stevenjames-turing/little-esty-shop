FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    sequence(:quantity) { |n| n.to_s }
    sequence(:status) { %w[pending packaged shipped].sample(1)[0] }
    unit_price { item.unit_price }
    item
    invoice
  end
end
