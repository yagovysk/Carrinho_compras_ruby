require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test "check dynamic fields and order submission" do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    # Testa se todos os campos de pagamento estão inicialmente ocultos
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Po number'

    # Seleciona 'Check' e verifica os campos
    select 'Check', from: 'Pay type'
    assert has_field? 'Routing number'
    assert has_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_no_field? 'Po number'

    # Seleciona 'Credit card' e verifica os campos
    select 'Credit card', from: 'Pay type'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_field? 'Credit card number'
    assert has_field? 'Expiration date'
    assert has_no_field? 'Po number'

    # Seleciona 'Purchase order' e verifica os campos
    select 'Purchase order', from: 'Pay type'
    assert has_no_field? 'Routing number'
    assert has_no_field? 'Account number'
    assert has_no_field? 'Credit card number'
    assert has_no_field? 'Expiration date'
    assert has_field? 'Po number'

    # Teste de envio do formulário com um pedido válido
    fill_in 'Name', with: 'John Doe'
    fill_in 'Address', with: '123 Main Street'
    fill_in 'Email', with: 'john@example.com'
    select 'Check', from: 'Pay type'
    fill_in 'Routing number', with: '123456789'
    fill_in 'Account number', with: '987654321'

    click_on 'Place Order'

    assert_text 'Thank you for your order.'
    assert_current_path store_index_path
  end

  test "should not submit empty order" do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Checkout'
    
    # Clicar diretamente em 'Place Order' sem preencher os campos
    click_on 'Place Order'

    assert_text "Name can't be blank"
    assert_text "Address can't be blank"
    assert_text "Email can't be blank"
    assert_text "Pay type can't be blank"
  end
end
