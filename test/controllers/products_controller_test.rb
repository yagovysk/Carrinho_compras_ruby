require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count", 1) do
      post products_url, params: { product: { 
        title: "New Product", 
        description: "Description of the new product", 
        image_url: "new_product_image.jpg", 
        price: 9.99 
      } }
    end
  
    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { 
      title: "Updated Product", 
      description: "Updated description", 
      image_url: "updated_image.jpg", 
      price: 12.99
    } }
  
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can't delete product in cart" do
    assert_difference("Product.count", 0) do
      delete product_url(products(:two))
    end
  
    assert_redirected_to products_url
  end
end
