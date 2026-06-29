class ChangeAuthorBooksNullOnAuthors < ActiveRecord::Migration[8.1]
  def change
    change_column_null :books, :author_id, true
  end
end
