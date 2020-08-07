class Trainer
  attr_accessor :prefered_type, :party
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
