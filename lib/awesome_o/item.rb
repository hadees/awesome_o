module AwesomeO
  class Item
    def initialize(item_id, cart_id, data)
      @id = item_id
      @cart_id = cart_id
      @data = data
    end

    def _id
      @id
    end

    def cost
      unit_cost = (@data.fetch(AwesomeO.config.unit_cost_field).to_f * 100).to_i
      quantity = @data.fetch(AwesomeO.config.quantity_field).to_i
      (unit_cost * quantity) / 100.0
    end

    def cart
      @cart ||= Cart.new(@cart_id)
    end

    def destroy
      cart.remove_item(self)
    end

    def ==(item)
      @id == item._id
    end

    def touch
      cart.touch
      redis.hincrby _key, :_version, 1
    end

    def _key
      "awesome_o:line_item:#{@id}"
    end

    def _version
      super.to_i
    end

    def cache_key
      "item/#{@id}-#{_version}"
    end

    def method_missing(method, *args, &block)
      if method.to_s.end_with?('=')
        redis.hset _key, method[0..-2], args[0].to_s
        @data.store(method[0..-2].to_sym, args[0].to_s)
        version = touch
        @data.store(:_version, version)
      elsif @data.keys.include?(method)
        @data.fetch(method)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      method.to_s.end_with?('=') || @data.keys.include?(method) || super
    end

    private

    def redis
      AwesomeO.config.redis
    end
  end
end
