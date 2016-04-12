require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    product = products(:ruby)
    line_item = line_items(:one)
    order = orders(:one)

    line_item.product = product
    line_item.order = order
    line_item.save!
    mail = OrderNotifier.received(order)
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
     product = products(:ruby)
     line_item = line_items(:one)
     order = orders(:one)

     line_item.product = product
     line_item.order = order
     line_item.save!
     
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end
end
