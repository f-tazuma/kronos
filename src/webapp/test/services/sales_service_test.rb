require_relative '../test_helper'
require_relative '../../app/services/sales_service'

class SalesServiceTest < ActiveSupport::TestCase

  def setup

  end

  test "売上計上処理" do
    sales_service = SalesService.new(1)
    sales_service.allocate_sales()
  end

end
