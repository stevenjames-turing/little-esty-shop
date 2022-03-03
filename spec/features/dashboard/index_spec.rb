require 'rails_helper'

RSpec.describe 'Dashboard Index' do
  it 'will have a header indicating that this is the admin dashboard page' do
    visit(admin_dashboard_index_url)
    expect(page).to have_content('Admin Dashboard')
  end
  it 'will have a link to the admin merchants index page' do
    visit(admin_dashboard_index_url)
    expect(page).to have_link('Admin Merchants Index')
    click_link('Admin Merchants Index')
    expect(current_path).to eq('/admin/merchants')
  end
  it 'will have a link to the admin invoices index page' do
    visit(admin_dashboard_index_url)
    expect(page).to have_link('Admin Invoices Index')
    click_link('Admin Invoices Index')
    expect(current_path).to eq('/admin/invoices')
  end
  describe 'top customers' do
    before :each do
      @customer_1 = create(:customer, first_name: 'Aaron', last_name: 'Adams')
      @customer_2 = create(:customer, first_name: 'Barry', last_name: 'Bonds')
      @customer_3 = create(:customer, first_name: 'Carl', last_name: 'Cassidy')
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_1.id)
      @invoice_3 = create(:invoice, customer_id: @customer_1.id)
      @invoice_4 = create(:invoice, customer_id: @customer_2.id)
      @invoice_5 = create(:invoice, customer_id: @customer_2.id)
      @invoice_6 = create(:invoice, customer_id: @customer_3.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 0)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 0)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 0)
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 0)
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 0)
    end

    it 'will return the names and transaction count of the top 2 customers' do
      visit(admin_dashboard_index_url)
      within '.top_customers' do
        expect(page).to have_content(@customer_1.first_name)
        expect(page).to have_content(@customer_1.last_name)
        expect(page).to have_content('Successful Transactions: 3')
      end
    end
  end

  describe 'incomplete invoices' do
    before :each do
      @invoice_1 = create(:invoice, created_at: '2012-03-07 14:54:15 UTC')
      @invoice_item_1 = create(:invoice_item, status: 'pending', invoice_id: @invoice_1.id)
      @invoice_item_2 = create(:invoice_item, status: 'shipped', invoice_id: @invoice_1.id)
      @invoice_item_3 = create(:invoice_item, status: 'packaged', invoice_id: @invoice_1.id)
      @invoice_2 = create(:invoice, created_at: '2012-03-08 14:54:15 UTC')
      @invoice_item_4 = create(:invoice_item, status: 'shipped', invoice_id: @invoice_2.id)
      @invoice_item_5 = create(:invoice_item, status: 'shipped', invoice_id: @invoice_2.id)
      @invoice_item_6 = create(:invoice_item, status: 'shipped', invoice_id: @invoice_2.id)
      @invoice_3 = create(:invoice, created_at: '2012-03-09 14:54:15 UTC')
      @invoice_item_7 = create(:invoice_item, status: 'packaged', invoice_id: @invoice_3.id)
      @invoice_item_8 = create(:invoice_item, status: 'packaged', invoice_id: @invoice_3.id)
      @invoice_item_9 = create(:invoice_item, status: 'packaged', invoice_id: @invoice_3.id)
    end

    it 'will list ids of all invoices that have not been shipped yet' do
      visit(admin_dashboard_index_url)
      within '.incomplete_invoices' do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_3.id)
        expect(page).to_not have_content(@invoice_2.id)
      end
    end

    it 'will have links to the invoice admin show page' do
      visit(admin_dashboard_index_url)
      within '.incomplete_invoices' do
        expect(page).to have_link(@invoice_1.id)
        expect(page).to have_link(@invoice_3.id)
        click_link(@invoice_1.id)
      end
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end

    it 'can order incomplete invoices oldest to newest' do
      visit(admin_dashboard_index_url)
      within '.incomplete_invoices' do
        expect(@invoice_1.id.to_s).to appear_before(@invoice_3.id.to_s)
        expect(@invoice_3.id.to_s).to_not appear_before(@invoice_1.id.to_s)
      end
    end

    it 'has the dates listed for each invoice' do
      visit(admin_dashboard_index_url)
      within '.incomplete_invoices' do
        expect(page).to have_content(date_formatter(@invoice_1.created_at))
        expect(page).to have_content(date_formatter(@invoice_3.created_at))
      end
    end
  end
end
