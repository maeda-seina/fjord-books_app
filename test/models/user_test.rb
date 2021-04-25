# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    alice = users(:alice)
    assert_equal 'alice@example.com', alice.name_or_email

    alice.name = 'Alice'
    assert_equal 'Alice', alice.name_or_email
  end

  test '#follow' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    alice.follow(bob)
    assert alice.following?(bob)
    assert bob.followed_by?(alice)
  end

  test '#unfollow' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    alice.follow(bob)
    alice.unfollow(bob)
    assert_not alice.following?(bob)
  end
end
