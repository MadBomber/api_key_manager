# api_key_manager/lib/api_key_manager/rate_limited.rb

class ApiKeyManager::RateLimited

  def initialize(api_keys:, delay: false, rate_count: 5, rate_period: 60)
    @api_keys       = api_keys.is_a?(String)  ? api_keys.split(',') : api_keys
    @delay          = delay
    @rate_count     = rate_count.is_a?(String)  ? rate_count.to_i   : rate_count
    @rate_period    = rate_period.is_a?(String) ? rate_period.to_i  : rate_period
    @start_timer    = Time.now.to_i
    @end_timer      = @start_timer - 1 # prevent delay
    @counter        = @rate_count
    @current_index  = 0
  end


  def reset_counter
    @counter  = @rate_count
  end


  def reset_timer
    now = Time.now.to_i

    if @delay && now < @end_timer
      delta = @end_timer - now
      sleep(delta)              # NOTE: Will block IO process
      now = Time.now.to_i
    end

    @start_timer  = now
    @end_timer    = @start_timer + @rate_period
  end


  def api_key
    now = Time.now.to_i

    if now <= @end_timer && @counter < 1
      @current_index  = (@current_index + 1) % @api_keys.length
      reset_timer
      reset_counter
    elsif now > @end_timer
      # Continue using same api key
      reset_timer
      reset_counter
    end

    @counter -= 1
    @api_keys[@current_index]
  end
  alias_method :key, :api_key
end
