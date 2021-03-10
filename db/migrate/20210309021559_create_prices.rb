class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.decimal :plan_price
      t.references :plan, foreign_key: true, null: false
      t.references :periodicity, foreign_key: true, null: false

      t.timestamps
    end
  end
end
