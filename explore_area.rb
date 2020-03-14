require "./area_maker.rb"

class NewArea
  include AreaMaker

  def self.get_location(prompt="Where are you? ")
    print prompt
    AreaMaker::info + STDIN.gets.chomp.downcase.split(" ").join("_") + ".txt"
  end

  def self.set_location
    @prompt = "What is the name of the new location? "
    @dex = Dex::pokedex
    @pool = []

    @area_file = File.open(self.get_location(@prompt), "r")
    @specific = eval(@area_file.gets) # line 1: Array or false
    if @specific.class == Array
      @specific.map! { |num| @dex[num-1] }
    else
      @specific = []
    end
    @dex_file = AreaMaker::store + @area_file.gets.chomp # line 2: String
    @size = eval(@area_file.gets) # line 3: Integer or false
    @evo =  eval(@area_file.gets) # line 4: Proc or false
    @types = eval(@area_file.gets) # line 5: Array or false
    @legend = eval(@area_file.gets) # line 6: Booleon or nil
  end

  def self.set_dex
    self.set_location
    @pool = DexMaker::filter_dex(@dex, @evo, @types, @legend)
    if @size == false
      DexMaker::create_dex(@pool, @dex_file, @specific)
    else
      DexMaker::create_dex(@pool, @dex_file, @specific, @size)
    end
  end
  self.set_dex
end
