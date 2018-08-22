require_relative '../../test_helper'
require_relative '../../../lib/assets/date_util'

class DateUtilTest < ActiveSupport::TestCase

  def setup
  end

  test 'get_days_by_week_num(2017, 10) should return array of 2017/3/6-2017/3/12' do
    days = DateUtil::get_days_by_week_num(2017, 10)
    assert_equal 7, days.size

    expect_days = []
    6.upto(12) do |day|
      expect_days.push(Date.new(2017, 3, day))
    end
    assert_equal expect_days, days
  end

  test 'get_weekdays_by_week_num(2017, 10) should return array of 2017/3/6-2017/3/10' do
    days = DateUtil::get_workdays_by_week_num(2017, 10)
    expect_days = []
    6.upto(10) do |day|
      expect_days.push(Date.new(2017, 3, day))
    end
    assert_equal expect_days, days
  end

end

