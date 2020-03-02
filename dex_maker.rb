require './dex.rb'

module DexMaker
  include Dex
  @new_dex = []
  @que = []

  def self.new_dex
    @new_dex
  end

  def self.que
    @que
  end

  def self.dex_pool(sort_proc)
    Dex::pokedex.select(&sort_proc)
  end

  def self.load_dex
    @seed = rand(0..@new_dex.size - 1)
    @specimen = @new_dex[@seed]
    if @que.none?(@specimen)
      @que << @specimen
    else
      self.load_dex
    end
  end

  def self.limit_pool(size)
    (0...size).each do |i|
      self.load_dex
    end
  end
end
