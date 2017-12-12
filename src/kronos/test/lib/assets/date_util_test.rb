require_relative '../../test_helper'
require_relative '../../../lib/assets/date_util'

class DateUtilTest < ActiveSupport::TestCase

  def setup
  end

  test 'getDatesByWeekNum(2017, 10) should return array of 2017/3/6-2017/3/12' do
    days = DateUtil::getDatesByWeekNum(2017, 10)
    assert_equal 7, days.size

    expect_days = []
    12.downto(6) do |day|
      expect_days.push(Date.new(2017, 3, day))
    end
    assert_equal expect_days, days
  end
end

