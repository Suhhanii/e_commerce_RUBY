class CreatePictures < ActiveRecord::Migration[8.1]
  def change
    create_table :pictures do |t|
      t.belongs_to :image, polymorphic: true
      t.timestamps
    end
  end
end
