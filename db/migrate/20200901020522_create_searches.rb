class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.text :search_text, null: false
      t.integer :recipe_count, default: 0

      t.timestamps
    end
    add_index(:searches, :search_text, unique: true)
  end
end
