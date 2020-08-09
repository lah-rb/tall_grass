require_relative '../dir_manager.rb'
require_relative '../prompt.rb'
require_relative "dex_craftsman.rb"
require_relative "evo.rb"

class Expedition
  include Prompt
  Environment = Struct.new(:name, :specific, :abundance, :evo, :type, :distinct, :priority)

  def embark_to(land_name)
    @director = DirManager.new
    @director.request_dir('backend')
    @all_seeds = Dir['./dex_seeds/*']
    unless land_name.nil?
      @seed = './dex_seeds/' + land_name.chomp.downcase.gsub(' ', '_') + '.rb'
    end

    if @all_seeds.include? @seed
      arrive_at(@seed)
    elsif land_name == 'all'
      @all_seeds.each { |land| arrive_at(land) }
    else
      display "We havn't found that place yet! Go find it!"
    end
  end

  def arrive_at(land_path)
    require_relative land_path

    @name, @specific, @abundance, @stages_arr, @types, @distinct, @priority \
    = NativeFruit.new.seed.dup
    @evolutions = Evo.new(@stages_arr)

    DexCraftsman.new(
      Environment.new(
        @name, @specific, @abundance, @evolutions, @types, @distinct, @priority
      )
    )
  end
end
