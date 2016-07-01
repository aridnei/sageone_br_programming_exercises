class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.string :description
      t.string :barcode
      t.string :ncm
      t.string :unity
      t.string :supplier
      t.string :product_type
      t.string :brand
      t.float :weight, default: 0.0
      t.string :size
      t.references :current_state, default: 0
      t.float :stock, default: 0.0
      t.float :max_stock, default: 0.0
      t.float :min_stock, default: 0.0
      t.float :purchase_stock, default: 0.0
      t.string :composition
      t.string :raw_material
      t.string :office_supplies
      t.string :for_sale
      t.string :currency
      t.string :observations
      t.float :cost, default: 0.0
      t.float :sale_price, default: 0.0
      t.float :ipi, default: 0.0
      t.string :category
      t.string :unity_factor
      t.string :gender

      t.timestamps null: false
    end

    add_index :products, :code, :unique => true
  end
end
