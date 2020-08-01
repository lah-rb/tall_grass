require 'set'
require_relative '../prompt.rb'

class Evo
  include Prompt
  AcceptableEvos = [1, 2, 3]

  def initialize(requested_stages = [])
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
    (1..AcceptableEvos.size).reduce(Set.new) do |evo_set, length|
      AcceptableEvos.combination(length).each do |comb|
        comb.permutation.each { |element| evo_set << element }
      end
      evo_set
    end
  end

  def verify_stages(requested_stages)
    if all_acceptable_evos.include?(requested_stages.uniq)
      self.class.verified_stages = requested_stages.to_set
    elsif requested_stages.empty?
      self.class.verified_stages = AcceptableEvos.to_set
    elsif requested_stages.include?(0)
      raise(BadEvoError, prompt_mint(:evoegg))
    else
      raise(BadEvoError, prompt_mint(:evobad, requested_stages))
    end
  end
end

class BadEvoError < StandardError; end
