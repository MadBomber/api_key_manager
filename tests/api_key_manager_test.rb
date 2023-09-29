# api_key_manager/tests/api_key_manager_test.rb

require 'minitest/autorun'
require_relative '../lib/api_key_manager'

class TestRate < Minitest::Test
  def setup
    @api_keys = ['key1', 'key2', 'key3']
  end

  def test_api_key_returns_a_key
    rate = ApiKeyManager::RateLimited.new(api_keys: @api_keys)

    assert_includes @api_keys, rate.api_key
  end


  def test_api_key_returns_a_new_key_after_rate_count
    rate = ApiKeyManager::RateLimited.new(api_keys: @api_keys, rate_count: 2)

    first_key  = rate.api_key
    second_key = rate.api_key
    third_key  = rate.api_key

    assert_equal @api_keys[0], first_key
    assert_equal @api_keys[0], second_key
    assert_equal @api_keys[1], third_key
  end


  def test_api_key_returns_a_new_key_after_rate_period
    rate = ApiKeyManager::RateLimited.new(api_keys: @api_keys, rate_period: 3)

    first_key  = rate.api_key
    second_key = rate.api_key

    sleep(4)

    third_key = rate.api_key

    assert_equal @api_keys[0], first_key
    assert_equal @api_keys[0], second_key
    assert_equal @api_keys[0], third_key
  end


  def test_api_key_returns_different_key_after_period_if_delay_is_true
    rate_period = 5
    rate  = ApiKeyManager::RateLimited.new(
              api_keys:     @api_keys,
              delay:        true,
              rate_count:   1,
              rate_period:  rate_period
            )

    start_time  = Time.now.to_i

    first_key   = rate.api_key
    second_key  = rate.api_key

    end_time    = Time.now.to_i
    delta_time  = end_time - start_time

    # show that the 2nd time was blocked until end of period
    # has expired.
    assert delta_time >= rate_period

    assert_equal @api_keys[0], first_key
    assert_equal @api_keys[1], second_key
  end
end
