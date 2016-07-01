require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { barcode: @product.barcode, brand: @product.brand, category: @product.category, code: @product.code, composition: @product.composition, cost: @product.cost, currency: @product.currency, current_state_id: @product.current_state_id, description: @product.description, for_sale: @product.for_sale, ipi: @product.ipi, max_stock: @product.max_stock, min_stock: @product.min_stock, ncm: @product.ncm, observations: @product.observations, office_supplies: @product.office_supplies, purchase_stock: @product.purchase_stock, raw_material: @product.raw_material, sale_price: @product.sale_price, stock: @product.stock, supplier: @product.supplier, type: @product.type, unity: @product.unity, weight: @product.weight }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { barcode: @product.barcode, brand: @product.brand, category: @product.category, code: @product.code, composition: @product.composition, cost: @product.cost, currency: @product.currency, current_state_id: @product.current_state_id, description: @product.description, for_sale: @product.for_sale, ipi: @product.ipi, max_stock: @product.max_stock, min_stock: @product.min_stock, ncm: @product.ncm, observations: @product.observations, office_supplies: @product.office_supplies, purchase_stock: @product.purchase_stock, raw_material: @product.raw_material, sale_price: @product.sale_price, stock: @product.stock, supplier: @product.supplier, type: @product.type, unity: @product.unity, weight: @product.weight }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
