class Trainer
  attr_accessor :job, :prefered_type, :party
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
