module DexMaker
  @refined_dex = Array.new

  def fill_dex(dex_pool)
    @seed = rand(0...dex_pool.size)
    @specimen = dex_pool[@seed]
    @refined_dex.none?(@specimen) ? @refined_dex << @specimen : fill_dex(dex_pool)
  end
  module_function :fill_dex

  def limit_pool(dex_pool, pages)
    if dex_pool.size > pages
      (0...pages).each { fill_dex(dex_pool) }
    else
      puts
      puts "There were not enough pokemon which meet requirements to fill a pokedex of that size."
      puts "The dex will be filled as much as possible"
      (0...dex_pool.size).each { fill_dex(dex_pool) }
    end

    return @refined_dex
  end
  module_function :limit_pool

  def type_select(dex_pool, type)
    if type.class == Array
      type.map!(&:capitalize)
      @keep_types = type.take_while { |type| type != '|' }
      @remove_types = type.drop_while { |type| type != '|' }
      @remove_types.shift

      @type_digest = dex_pool.select do |dex|
        @keep_types.any?(dex[3]) || @keep_types.any?(dex[4])
      end

      @type_digest.reject! do |dex|
        @remove_types.any?(dex[3]) || @remove_types.any?(dex[4])
      end
      return @type_digest
    else
      return dex_pool
    end
  end
  module_function :type_select

  def legend_select(dex_pool, legendary)
    dex_pool.select { |dex| dex[1][-1].match?(/["^"|!|#]/) }
  end
    module_function :legend_select

  def evo_select(dex_pool, evolution)
    if evolution
      dex_pool.select(&evolution)
    else
      return dex_pool
    end
  end
  module_function :evo_select

  def filter_dex(dex_raw, evolution, types, legendary)
    @type_dex = type_select(dex_raw, types)
    @evo_dex = evo_select(@type_dex, evolution) if legendary.start_with? != 'o'
    @legend_dex = legend_select(@type_dex, legendary) unless legendary.empty?
    case legendary
    when 'only', 'o'
      return @legend_dex
    when 'yes', 'y'
      return @evo_dex << @legend_dex
    when 'no', 'n'
      return @evo_dex - @legend_dex
    else
      return @evo_dex
    end
  end
  module_function :filter_dex

  def write_dex(refined_dex, file_name)
    File.open(file_name, 'w') do |new_dex|
      refined_dex.each do |entry|
        @line = ""
        (0...entry.size).each do
          @line += entry.shift + "-"
        end
        new_dex.puts("#{@line.chop}")
      end
    end
  end
  module_function :write_dex

  def teaming
    base = rand(1..100)
    case base
    when (1..40)
      return 7
    when (41..86)
      return 12 + rand(0..8) + rand(0..2) * 5
    when (87..96)
      return rand(0..1)*10 + rand(0..1)*20 + rand(0..3) * 10
    when (97..100)
      return 1
    end
  end
  module_function :teaming

  def crush_empties
    @refined_dex.reject! { |e| e.empty? }
  end
  module_function :crush_empties

  # Dex_pool is array, pages is integer, file is string, type is array
  def create_dex(dex_pool, file, specified, size=teaming)
    crush_empties
    @additional_pages = size - specified.size
    @refined_dex += specified
    crush_empties
    limit_pool(dex_pool, @additional_pages) if @additional_pages != 0
    crush_empties
    write_dex(@refined_dex, file)
  end
  module_function :create_dex
end
