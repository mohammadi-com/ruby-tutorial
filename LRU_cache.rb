class LRUCache
  attr_reader :cache, :capacity
  def initialize(capacity)
    raise ArgumentError, "capacity must be >= 1" if capacity < 1
    @cache = {}
    @capacity = capacity
  end

  def get(key)
    return nil unless @cache.key?(key)
    value = @cache.delete(key)
    @cache[key] = value
    value
  end

  def set(key, value)
    @cache.delete(key)
    @cache.shift if @cache.size >= @capacity
    @cache[key] = value
    value
  end

  def size
    @cache.size
  end

  def keys
    @cache.keys.reverse
  end
end