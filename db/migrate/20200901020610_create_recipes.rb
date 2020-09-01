class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.text :title, null: false
      t.integer :ingredient_count, null: false
      t.text :ingredients, null: false
      t.text :link
      t.integer :search_id, null: false

      t.timestamps
    end
    add_index(:recipes, :search_id)
  end
end
