def create_book_order
  Book::Order.create!(quantity: 1,status: nil,book_id: 1)
rescue ActiveRecord::RecordInvalid,ActiveRecord::NotNullViolation
  puts "Record is invalid"
end
