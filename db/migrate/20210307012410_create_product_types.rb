class CreateProductTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_types do |t|
      t.string :name
      t.text :description
      t.string :product_key

      t.timestamps
    end
  end
end
