# frozen_string_literal: true

class BaseCommand
  def play
    raise NotImplementedError, "class #{self.class.name} has not implemented #{__method__}"
  end
end
