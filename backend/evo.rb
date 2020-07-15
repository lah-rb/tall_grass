require 'set'
require_relative '../prompt.rb'

class Evo
  include Prompt

  def initialize(requested_stages = [])
    @acceptable_evos = [1, 2, 3]
    verify_stages(requested_stages)
  end

  def self.to_proc
    Proc.new { |entry| verified_stages.include?(entry.evo) }
  end

  private

  class << self
    attr_accessor :verified_stages
  end

  def all_acceptable_evos
    (1..@acceptable_evos.size - 1).reduce(Set.new) do |evo_set, length|
      @acceptable_evos.combination(length).each do |comb|
        comb.permutation.each { |element| evo_set << element }
      end
      evo_set
    end
  end

  def verify_stages(requested_stages)
    if all_acceptable_evos.include?(requested_stages)
      self.class.verified_stages = requested_stages.to_set
    elsif requested_stages.empty? || requested_stages == @acceptable_evos
      self.class.verified_stages = @acceptable_evos.to_set
    elsif requested_stages.include?(0)
      raise(BadEvoError, prompt_mint(9))
    else
      raise(BadEvoError, prompt_mint(10, requested_stages))
    end
  end
end

class BadEvoError < StandardError; end
