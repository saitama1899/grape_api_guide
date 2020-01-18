class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.boolean :shipped
      t.boolean :delivered
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
