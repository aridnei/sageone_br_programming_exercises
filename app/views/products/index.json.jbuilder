json.array!(@products) do |product|
  json.extract! product, :id, :code, :description, :barcode, :ncm, :unity, :supplier, :type, :brand, :weight, :current_state_id, :stock, :max_stock, :min_stock, :purchase_stock, :composition, :raw_material, :office_supplies, :for_sale, :currency, :observations, :cost, :sale_price, :ipi, :category
  json.url product_url(product, format: :json)
end
