require './app/models/customer'
class Admin < ApplicationRecord
  #include Customer
#has_many :customers

def self.top_customers(count)
  #binding.pry
  customer = Customer.find_by_sql("SELECT customers.* FROM customers
                        JOIN invoices ON customers.id = invoices.customer_id
                        JOIN invoice_items ON invoices.id = invoice_items.invoice_id
                        JOIN items ON invoice_items.item_id = items.id
                        JOIN merchants ON items.merchant_id = merchants.id
                        JOIN transactions on transactions.invoice_id = invoices.id

                        WHERE transactions.result = 0

                        GROUP BY customers.id
                        ORDER BY COUNT(transactions.id) DESC

                        LIMIT #{count}")
end

end
