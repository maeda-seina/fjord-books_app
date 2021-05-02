# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    assert_equal 'alice@example.com', users(:alice).name_or_email
    users(:alice).name = 'Alice'
    assert_equal 'Alice', users(:alice).name_or_email
  end

  test '#follow' do
    assert_not users(:alice).following?(users(:bob))
    users(:alice).follow(users(:bob))
    assert users(:alice).following?(users(:bob))
    assert users(:bob).followed_by?(users(:alice))
  end

  test '#unfollow' do
    assert_not users(:alice).following?(users(:bob))
    users(:alice).follow(users(:bob))
    users(:alice).unfollow(users(:bob))
    assert_not users(:alice).following?(users(:bob))
  end
end
