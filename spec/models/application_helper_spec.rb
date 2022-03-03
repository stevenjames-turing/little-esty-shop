require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'instance methods' do 
    describe '.date_formatter(string' do 
        it 'formats UTC dates to Weekday, Month Day Year' do 
            invoice = create(:invoice, created_at: '2012-03-27 14:54:09 UTC')
            expect(date_formatter(invoice.created_at)).to eq("Tuesday, March 27, 2012")
        end
    end

    describe '.sortable(data, params)' do 
        it 'uses sort param to sort data passed as arg' do 
            invoice_1 = create(:invoice, created_at: '2012-03-22 14:54:09 UTC', status: 1)
            invoice_2 = create(:invoice, created_at: '2012-03-17 14:54:09 UTC', status: 1)
            invoice_3 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC', status: 1)
            invoice_4 = create(:invoice, created_at: '2012-03-12 14:54:09 UTC', status: 1)
            data = Invoice.all
            params = {sort: :created_at, controller: "invoices"}
            
            expect(sortable(data, params)).to eq([invoice_4, invoice_2, invoice_1, invoice_3])
            
            params = {sort: :name, controller: "invoices"}
            expect(sortable(data, params)).to eq([invoice_1, invoice_2, invoice_3, invoice_4])
        end
    end
  end
end 