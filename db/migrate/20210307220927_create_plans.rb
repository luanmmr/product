class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.references :product_type, null: false, foreign_key: true
      t.text :details

      t.timestamps
    end
  end
end
