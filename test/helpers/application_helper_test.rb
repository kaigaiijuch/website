require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'title should return with base title' do
    set_title('test')
    assert_equal '海外移住channel:test', title

    set_title('')
    assert_equal '海外移住channel', title
  end
end
