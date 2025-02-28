# frozen_string_literal: true

class BaseBuilder
  def self.call(*args, **kwargs)
    new(*args, **kwargs).build
  end

  def build
    raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
  end
end
