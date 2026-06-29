class AddBooksCountToAuthors < ActiveRecord::Migration[8.1]
  def change
    add_column :authors, :author_books , :integer, default: 0,null: false
  end
end
