require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  it 'exists' do
    visit '/admin'

    expect(page).to have_content("Admin Dashboard")
  end

  it 'links to admin merchants' do
    visit '/admin'
    click_link 'Merchants'

    expect(current_path).to eq("/admin/merchants")
  end

  it 'links to admin invoices' do
    visit '/admin'
    click_link 'Invoices'

    expect(current_path).to eq("/admin/invoices")
  end

  it 'Displays top customers' do
  
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)

    customer_2 = create(:customer)
    invoice_2 = create(:invoice, customer_id: customer_2.id)
    invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_2.id)

    customer_3 = create(:customer)
    invoice_3 = create(:invoice, customer_id: customer_3.id)
    invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_3.id)
    transaction_5 = create(:transaction, invoice_id: invoice_3.id)
    transaction_6 = create(:transaction, invoice_id: invoice_3.id)

    customer_4 = create(:customer)
    invoice_4 = create(:invoice, customer_id: customer_4.id)
    invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id)
    transaction_7 = create(:transaction, invoice_id: invoice_4.id)
    transaction_8 = create(:transaction, invoice_id: invoice_4.id)
    transaction_9 = create(:transaction, invoice_id: invoice_4.id)
    transaction_10 = create(:transaction, invoice_id: invoice_4.id)
    transaction_21 = create(:transaction, invoice_id: invoice_4.id)

    customer_5 = create(:customer)
    invoice_5 = create(:invoice, customer_id: customer_5.id)
    invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id)
    transaction_11 = create(:transaction, invoice_id: invoice_5.id)
    transaction_12 = create(:transaction, invoice_id: invoice_5.id)
    transaction_13 = create(:transaction, invoice_id: invoice_5.id)
    transaction_14 = create(:transaction, invoice_id: invoice_5.id)

    customer_6 = create(:customer)
    invoice_6 = create(:invoice, customer_id: customer_6.id)
    invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id)
    transaction_15 = create(:transaction, invoice_id: invoice_6.id)
    transaction_16 = create(:transaction, invoice_id: invoice_6.id)
    transaction_17 = create(:transaction, invoice_id: invoice_6.id)
    transaction_18 = create(:transaction, invoice_id: invoice_6.id)
    transaction_19 = create(:transaction, invoice_id: invoice_6.id)
    transaction_20 = create(:transaction, invoice_id: invoice_6.id)

    visit '/admin'

    expect(page).to have_content("Top Customers")
    expect(page).to have_content(customer_6.first_name)
    expect(page).to have_content(customer_5.first_name)
    expect(page).to have_content(customer_4.first_name)
    expect(page).to have_content(customer_3.first_name)
    expect(page).to have_content(customer_2.first_name)
    expect(page).to_not have_content(customer_1.first_name)
    expect(page).to have_content(Customer.transaction_count(customer_4.id))
    expect(page).to have_content(Customer.transaction_count(customer_5.id))
    expect(page).to have_content(Customer.transaction_count(customer_6.id))
    expect(page).to have_content(Customer.transaction_count(customer_3.id))
    expect(page).to have_content(Customer.transaction_count(customer_2.id))

    expect(customer_6.first_name).to appear_before(customer_4.first_name)
    expect(customer_4.first_name).to appear_before(customer_5.first_name)
    expect(customer_5.first_name).to appear_before(customer_3.first_name)
    expect(customer_3.first_name).to appear_before(customer_2.first_name)
  end




end
