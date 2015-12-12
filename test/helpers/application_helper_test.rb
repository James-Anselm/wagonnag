require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal(full_title, 'Wagonnag - prevent the engine light')
    assert_equal(full_title('Help'), 'Help | Wagonnag - prevent the engine light')
  end
end